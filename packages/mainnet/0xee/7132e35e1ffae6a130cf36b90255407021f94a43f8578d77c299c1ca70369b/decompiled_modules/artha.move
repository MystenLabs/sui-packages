module 0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha {
    struct ARTHA has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RewardPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<ARTHA>,
        total_burned: u64,
        total_distributed: u64,
        current_price: u64,
    }

    struct PriceUpdated has copy, drop {
        old_price: u64,
        new_price: u64,
    }

    struct PayInEvent has copy, drop {
        amount: u64,
        burned: u64,
        pooled: u64,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ARTHA>, arg1: 0x2::coin::Coin<ARTHA>) {
        assert!(0x2::coin::value<ARTHA>(&arg1) > 0, 0);
        0x2::coin::burn<ARTHA>(arg0, arg1);
    }

    public fun current_price(arg0: &RewardPool) : u64 {
        arg0.current_price
    }

    public entry fun distribute(arg0: &mut RewardPool, arg1: &AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
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
            current_price     : 100000,
        };
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ARTHA>>(0x2::coin::mint<ARTHA>(&mut v2, 1610800000000000000, arg1), v5);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARTHA>>(v2, v5);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARTHA>>(v1);
        0x2::transfer::share_object<RewardPool>(v3);
        0x2::transfer::public_transfer<AdminCap>(v4, v5);
    }

    public entry fun multi_send(arg0: &mut 0x2::coin::Coin<ARTHA>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<ARTHA>>(0x2::coin::split<ARTHA>(arg0, *0x1::vector::borrow<u64>(&arg2, v0), arg3), *0x1::vector::borrow<address>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun pay_in(arg0: &mut 0x2::coin::TreasuryCap<ARTHA>, arg1: &mut RewardPool, arg2: 0x2::coin::Coin<ARTHA>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<ARTHA>(&arg2);
        assert!(v0 > 0, 0);
        let v1 = v0 * 80 / 100;
        let v2 = v0 - v1;
        0x2::coin::burn<ARTHA>(arg0, arg2);
        arg1.total_burned = arg1.total_burned + v1;
        0x2::balance::join<ARTHA>(&mut arg1.balance, 0x2::coin::into_balance<ARTHA>(0x2::coin::split<ARTHA>(&mut arg2, v2, arg3)));
        let v3 = PayInEvent{
            amount : v0,
            burned : v1,
            pooled : v2,
        };
        0x2::event::emit<PayInEvent>(v3);
    }

    public fun pool_balance(arg0: &RewardPool) : u64 {
        0x2::balance::value<ARTHA>(&arg0.balance)
    }

    public fun total_burned(arg0: &RewardPool) : u64 {
        arg0.total_burned
    }

    public entry fun update_price(arg0: &mut RewardPool, arg1: &AdminCap, arg2: u64) {
        arg0.current_price = arg2;
        let v0 = PriceUpdated{
            old_price : arg0.current_price,
            new_price : arg2,
        };
        0x2::event::emit<PriceUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

