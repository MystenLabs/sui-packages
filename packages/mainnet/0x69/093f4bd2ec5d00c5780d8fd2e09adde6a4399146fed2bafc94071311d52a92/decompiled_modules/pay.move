module 0x69093f4bd2ec5d00c5780d8fd2e09adde6a4399146fed2bafc94071311d52a92::pay {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PayConfig has key {
        id: 0x2::object::UID,
        treasury: address,
        fee_bps: u64,
        max_price_mist: u64,
        used: 0x2::table::Table<vector<u8>, bool>,
    }

    struct Paid has copy, drop {
        nonce: vector<u8>,
        payer: address,
        recipient: address,
        amount: u64,
        fee: u64,
    }

    public fun pay(arg0: &mut PayConfig, arg1: vector<u8>, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u8>(&arg1);
        assert!(v0 >= 16 && v0 <= 32, 3);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.used, arg1), 0);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v1 > 0, 1);
        assert!(v1 <= arg0.max_price_mist, 2);
        0x2::table::add<vector<u8>, bool>(&mut arg0.used, arg1, true);
        let v2 = fee_on(v1, arg0.fee_bps);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v2, arg4), arg0.treasury);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg2);
        let v3 = Paid{
            nonce     : arg1,
            payer     : 0x2::tx_context::sender(arg4),
            recipient : arg2,
            amount    : v1,
            fee       : v2,
        };
        0x2::event::emit<Paid>(v3);
    }

    fun fee_on(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 10000) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PayConfig{
            id             : 0x2::object::new(arg0),
            treasury       : @0x8e0e9fecb8141cc2635effcb1a0d25c96331eecae8eb998329c47241259abb6a,
            fee_bps        : 1000,
            max_price_mist : 500000000,
            used           : 0x2::table::new<vector<u8>, bool>(arg0),
        };
        0x2::transfer::share_object<PayConfig>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun set_fee_bps(arg0: &AdminCap, arg1: &mut PayConfig, arg2: u64) {
        assert!(arg2 <= 2000, 4);
        arg1.fee_bps = arg2;
    }

    public fun set_max_price(arg0: &AdminCap, arg1: &mut PayConfig, arg2: u64) {
        assert!(arg2 > 0, 5);
        arg1.max_price_mist = arg2;
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut PayConfig, arg2: address) {
        arg1.treasury = arg2;
    }

    // decompiled from Move bytecode v7
}

