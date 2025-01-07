module 0xa283fd6b45f1103176e7ae27e870c89df7c8783b15345e2b13faa81ec25c4fa6::admin {
    struct Config has key {
        id: 0x2::object::UID,
        streamflow_fee: u64,
        treasury: address,
        withdrawor: address,
        tx_fee: u64,
        version: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct AddressValue has store {
        address: address,
    }

    struct AdminTransfered has copy, drop {
        new_address: address,
        old_address: address,
    }

    struct FeeManagerChanged has copy, drop {
        new_address: address,
        old_address: address,
    }

    struct TreasuryChanged has copy, drop {
        new_address: address,
        old_address: address,
    }

    struct WithdraworChanged has copy, drop {
        new_address: address,
        old_address: address,
    }

    struct StreamflowFeeChanged has copy, drop {
        new_fee: u64,
        old_fee: u64,
    }

    struct TxFeeChanged has copy, drop {
        new_fee: u64,
        old_fee: u64,
    }

    public entry fun change_fee_manager(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"fee_manager")) {
            let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, AddressValue>(&mut arg1.id, b"fee_manager");
            let v1 = FeeManagerChanged{
                new_address : arg2,
                old_address : v0.address,
            };
            0x2::event::emit<FeeManagerChanged>(v1);
            update_address_value(v0, arg2);
        } else {
            let v2 = FeeManagerChanged{
                new_address : arg2,
                old_address : @0x0,
            };
            0x2::event::emit<FeeManagerChanged>(v2);
            let v3 = AddressValue{address: arg2};
            0x2::dynamic_field::add<vector<u8>, AddressValue>(&mut arg1.id, b"fee_manager", v3);
        };
    }

    public entry fun change_streamflow_fee(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        write_streamflow_fee_to_config(arg1, arg2);
    }

    public entry fun change_streamflow_fee_as_manager(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == get_fee_manager(arg0), 2);
        write_streamflow_fee_to_config(arg0, arg1);
    }

    public entry fun change_treasury(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        let v0 = TreasuryChanged{
            new_address : arg2,
            old_address : arg1.treasury,
        };
        0x2::event::emit<TreasuryChanged>(v0);
        arg1.treasury = arg2;
    }

    public entry fun change_tx_fee(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.withdrawor, 1);
        let v0 = TxFeeChanged{
            new_fee : arg1,
            old_fee : arg0.tx_fee,
        };
        0x2::event::emit<TxFeeChanged>(v0);
        arg0.tx_fee = arg1;
    }

    public entry fun change_withdrawor(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        let v0 = WithdraworChanged{
            new_address : arg2,
            old_address : arg1.withdrawor,
        };
        0x2::event::emit<WithdraworChanged>(v0);
        arg1.withdrawor = arg2;
    }

    public fun get_fee_manager(arg0: &Config) : address {
        0x2::dynamic_field::borrow<vector<u8>, AddressValue>(&arg0.id, b"fee_manager").address
    }

    public fun get_streamflow_fee(arg0: &Config) : u64 {
        arg0.streamflow_fee
    }

    public fun get_treasury(arg0: &Config) : address {
        arg0.treasury
    }

    public fun get_tx_fee(arg0: &Config) : u64 {
        arg0.tx_fee
    }

    public fun get_withdrawor(arg0: &Config) : address {
        arg0.withdrawor
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Config{
            id             : 0x2::object::new(arg0),
            streamflow_fee : 25,
            treasury       : v0,
            withdrawor     : v0,
            tx_fee         : 5000000,
            version        : 1,
        };
        0x2::transfer::share_object<Config>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public entry fun transfer_admin(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminTransfered{
            new_address : arg1,
            old_address : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<AdminTransfered>(v0);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    fun update_address_value(arg0: &mut AddressValue, arg1: address) {
        arg0.address = arg1;
    }

    fun write_streamflow_fee_to_config(arg0: &mut Config, arg1: u64) {
        assert!(arg1 <= 10000, 1);
        let v0 = StreamflowFeeChanged{
            new_fee : arg1,
            old_fee : arg0.streamflow_fee,
        };
        0x2::event::emit<StreamflowFeeChanged>(v0);
        arg0.streamflow_fee = arg1;
    }

    // decompiled from Move bytecode v6
}

