module 0xb1ffc523a89147aacb6ebd209fe8821b94909bb00f27c690d96bd55e50a530dd::suister_go {
    struct SUISTER_GO has drop {
        dummy_field: bool,
    }

    struct MaxSupply has store, key {
        id: 0x2::object::UID,
        max: u64,
        total_supply: u64,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<SUISTER_GO>,
    }

    struct SupplyInfo has key {
        id: 0x2::object::UID,
        circulating_supply: u64,
    }

    struct SwapEvent has copy, drop {
        user: address,
        sui_amount: u64,
        stg_amount: u64,
        timestamp: u64,
    }

    public fun add_to_treasury(arg0: &mut Treasury, arg1: 0x2::coin::Coin<SUISTER_GO>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xf49cd4790cd9572ba24d432a303dd2c8a2fb90b3ca2ae893314e40135eaf39f2, 1003);
        0x2::balance::join<SUISTER_GO>(&mut arg0.balance, 0x2::coin::into_balance<SUISTER_GO>(arg1));
    }

    public fun get_circulating_supply(arg0: &SupplyInfo) : u64 {
        arg0.circulating_supply
    }

    public fun get_max_supply(arg0: &MaxSupply) : u64 {
        arg0.max
    }

    public fun get_total_supply(arg0: &MaxSupply) : u64 {
        arg0.total_supply
    }

    public fun get_treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<SUISTER_GO>(&arg0.balance)
    }

    fun init(arg0: SUISTER_GO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUISTER_GO>(arg0, 9, b"STG", b"Suister Go", b"A core driver of the Suister Go economy is $STG, the game's native utility token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiaf6fg5wf4buhyn4b4mmhr5ymyyobbgwu7g2a2q25z2tapxpbjq7u")), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISTER_GO>>(v2);
        let v4 = 10000000000000000000;
        let v5 = 0x2::coin::mint<SUISTER_GO>(&mut v3, v4, arg1);
        let v6 = Treasury{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<SUISTER_GO>(0x2::coin::split<SUISTER_GO>(&mut v5, 100000000000000000, arg1)),
        };
        0x2::transfer::share_object<Treasury>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISTER_GO>>(v5, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTER_GO>>(v3, v0);
        let v7 = MaxSupply{
            id           : 0x2::object::new(arg1),
            max          : v4,
            total_supply : v4,
        };
        0x2::transfer::share_object<MaxSupply>(v7);
        let v8 = SupplyInfo{
            id                 : 0x2::object::new(arg1),
            circulating_supply : v4,
        };
        0x2::transfer::share_object<SupplyInfo>(v8);
    }

    public fun swap_sui_for_stg(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::balance::value<SUISTER_GO>(&arg0.balance) >= arg2, 1002);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0xf49cd4790cd9572ba24d432a303dd2c8a2fb90b3ca2ae893314e40135eaf39f2);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISTER_GO>>(0x2::coin::from_balance<SUISTER_GO>(0x2::balance::split<SUISTER_GO>(&mut arg0.balance, arg2), arg3), v0);
        let v1 = SwapEvent{
            user       : v0,
            sui_amount : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            stg_amount : arg2,
            timestamp  : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<SwapEvent>(v1);
    }

    public fun withdraw_from_treasury(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xf49cd4790cd9572ba24d432a303dd2c8a2fb90b3ca2ae893314e40135eaf39f2, 1003);
        assert!(0x2::balance::value<SUISTER_GO>(&arg0.balance) >= arg1, 1004);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUISTER_GO>>(0x2::coin::from_balance<SUISTER_GO>(0x2::balance::split<SUISTER_GO>(&mut arg0.balance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

