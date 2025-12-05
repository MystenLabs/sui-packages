module 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::global_config {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        volatile_fee: u64,
        stable_fee: u64,
        protocol_fee: u64,
        treasury: address,
        paused: bool,
        distribution_config: DistributionConfig,
    }

    struct Recipient has copy, drop, store {
        address: address,
        rate: u64,
    }

    struct DistributionConfig has copy, drop, store {
        to_gauge_rate: u64,
        recipients: vector<Recipient>,
    }

    public fun addr(arg0: &Recipient) : address {
        arg0.address
    }

    fun check_distribution_config(arg0: &DistributionConfig) {
        assert!(arg0.to_gauge_rate <= 10000, 13906834732689129471);
        let v0 = 0;
        let v1 = arg0.recipients;
        0x1::vector::reverse<Recipient>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Recipient>(&v1)) {
            let v3 = 0x1::vector::pop_back<Recipient>(&mut v1);
            v0 = v0 + v3.rate;
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<Recipient>(v1);
        assert!(v0 == 10000, 13906834758458933247);
    }

    public fun distribution_config(arg0: &GlobalConfig) : &DistributionConfig {
        &arg0.distribution_config
    }

    public fun fee(arg0: &GlobalConfig, arg1: bool) : u64 {
        if (arg1) {
            arg0.stable_fee
        } else {
            arg0.volatile_fee
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Recipient{
            address : @0xe1577a68764fc00f0e5c1e368bfca5fe5854ce56a172d286659214a5ee39cf51,
            rate    : 10000,
        };
        let v1 = 0x1::vector::empty<Recipient>();
        0x1::vector::push_back<Recipient>(&mut v1, v0);
        let v2 = DistributionConfig{
            to_gauge_rate : 7000,
            recipients    : v1,
        };
        let v3 = GlobalConfig{
            id                  : 0x2::object::new(arg0),
            volatile_fee        : 30,
            stable_fee          : 30,
            protocol_fee        : 5000,
            treasury            : @0x0,
            paused              : false,
            distribution_config : v2,
        };
        let v4 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<GlobalConfig>(v3);
        0x2::transfer::transfer<AdminCap>(v4, 0x2::tx_context::sender(arg0));
    }

    public fun paused(arg0: &GlobalConfig) : bool {
        arg0.paused
    }

    public fun protocol_fee(arg0: &GlobalConfig) : u64 {
        arg0.protocol_fee
    }

    public fun rate(arg0: &Recipient) : u64 {
        arg0.rate
    }

    public fun recipients(arg0: &DistributionConfig) : &vector<Recipient> {
        &arg0.recipients
    }

    entry fun set_distribution_config(arg0: &mut GlobalConfig, arg1: u64, arg2: vector<address>, arg3: vector<u64>, arg4: &AdminCap) {
        let v0 = 0x1::vector::empty<Recipient>();
        0x1::vector::reverse<u64>(&mut arg3);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 13906834784228737023);
        0x1::vector::reverse<address>(&mut arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            let v2 = Recipient{
                address : 0x1::vector::pop_back<address>(&mut arg2),
                rate    : 0x1::vector::pop_back<u64>(&mut arg3),
            };
            0x1::vector::push_back<Recipient>(&mut v0, v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
        0x1::vector::destroy_empty<u64>(arg3);
        let v3 = DistributionConfig{
            to_gauge_rate : arg1,
            recipients    : v0,
        };
        check_distribution_config(&v3);
        arg0.distribution_config = v3;
    }

    entry fun set_fee(arg0: &mut GlobalConfig, arg1: u64, arg2: bool, arg3: &AdminCap) {
        if (arg2) {
            arg0.stable_fee = arg1;
        } else {
            arg0.volatile_fee = arg1;
        };
    }

    entry fun set_paused(arg0: &mut GlobalConfig, arg1: bool, arg2: &AdminCap) {
        arg0.paused = arg1;
    }

    entry fun set_protocol_fee(arg0: &mut GlobalConfig, arg1: u64, arg2: &AdminCap) {
        arg0.protocol_fee = arg1;
    }

    entry fun set_treasury(arg0: &mut GlobalConfig, arg1: address, arg2: &AdminCap) {
        arg0.treasury = arg1;
    }

    public fun to_gauge_rate(arg0: &DistributionConfig) : u64 {
        arg0.to_gauge_rate
    }

    public fun treasury(arg0: &GlobalConfig) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v6
}

