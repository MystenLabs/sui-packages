module 0x410f36415c216949d76c1d39903402cb2da752371c4c899ccb8e2c9a8cc61646::artha {
    struct ARTHA has drop {
        dummy_field: bool,
    }

    struct RewardPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<ARTHA>,
        total_burned: u64,
        total_distributed: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ARTHA>, arg1: 0x2::coin::Coin<ARTHA>) {
        assert!(0x2::coin::value<ARTHA>(&arg1) > 0, 2);
        0x2::coin::burn<ARTHA>(arg0, arg1);
    }

    public fun distribute(arg0: &mut RewardPool, arg1: &AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 2);
        assert!(0x2::balance::value<ARTHA>(&arg0.balance) >= arg2, 1);
        arg0.total_distributed = arg0.total_distributed + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<ARTHA>>(0x2::coin::from_balance<ARTHA>(0x2::balance::split<ARTHA>(&mut arg0.balance, arg2), arg4), arg3);
    }

    fun init(arg0: ARTHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARTHA>(arg0, 8, b"ARTHA", b"ARTHA", b"Multifunctional Intelligent Hybrid Token-Agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://artha.world/artha-icon.png")), arg1);
        let v2 = v0;
        let v3 = RewardPool{
            id                : 0x2::object::new(arg1),
            balance           : 0x2::balance::zero<ARTHA>(),
            total_burned      : 0,
            total_distributed : 0,
        };
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ARTHA>>(0x2::coin::mint<ARTHA>(&mut v2, 1610800000000000000, arg1), v5);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARTHA>>(v2, v5);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARTHA>>(v1);
        0x2::transfer::share_object<RewardPool>(v3);
        0x2::transfer::public_transfer<AdminCap>(v4, v5);
    }

    public fun multi_send(arg0: &mut 0x2::coin::Coin<ARTHA>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<ARTHA>>(0x2::coin::split<ARTHA>(arg0, *0x1::vector::borrow<u64>(&arg2, v0), arg3), *0x1::vector::borrow<address>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    public fun pay_in(arg0: &mut 0x2::coin::TreasuryCap<ARTHA>, arg1: &mut RewardPool, arg2: 0x2::coin::Coin<ARTHA>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<ARTHA>(&arg2);
        assert!(v0 > 0, 2);
        let v1 = v0 * 80 / 100;
        0x2::coin::burn<ARTHA>(arg0, arg2);
        arg1.total_burned = arg1.total_burned + v1;
        0x2::balance::join<ARTHA>(&mut arg1.balance, 0x2::coin::into_balance<ARTHA>(0x2::coin::split<ARTHA>(&mut arg2, v0 - v1, arg3)));
    }

    public fun pool_balance(arg0: &RewardPool) : u64 {
        0x2::balance::value<ARTHA>(&arg0.balance)
    }

    public fun total_burned(arg0: &RewardPool) : u64 {
        arg0.total_burned
    }

    public fun total_distributed(arg0: &RewardPool) : u64 {
        arg0.total_distributed
    }

    // decompiled from Move bytecode v7
}

