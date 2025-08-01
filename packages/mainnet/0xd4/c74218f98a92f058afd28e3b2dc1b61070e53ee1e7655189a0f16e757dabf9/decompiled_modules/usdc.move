module 0xd4c74218f98a92f058afd28e3b2dc1b61070e53ee1e7655189a0f16e757dabf9::usdc {
    struct Limiter has store {
        epoch: u64,
        counter: u64,
    }

    struct USDC has drop {
        dummy_field: bool,
    }

    struct USDCSupply has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<USDC>,
        limits: 0x2::table::Table<address, Limiter>,
        admins: 0x2::vec_set::VecSet<address>,
    }

    struct InitEvent has copy, drop {
        sender: address,
        suplyID: 0x2::object::ID,
        decimals: u8,
    }

    public entry fun faucet(arg0: &mut USDCSupply, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg1);
        if (!0x2::table::contains<address, Limiter>(&arg0.limits, 0x2::tx_context::sender(arg1))) {
            let v1 = Limiter{
                epoch   : v0,
                counter : 0,
            };
            0x2::table::add<address, Limiter>(&mut arg0.limits, 0x2::tx_context::sender(arg1), v1);
        };
        let v2 = 0x2::table::borrow_mut<address, Limiter>(&mut arg0.limits, 0x2::tx_context::sender(arg1));
        if (v2.epoch < v0) {
            v2.epoch = v0;
            v2.counter = 0;
        };
        v2.counter = v2.counter + 1;
        assert!(v2.counter <= 10, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::from_balance<USDC>(0x2::balance::increase_supply<USDC>(&mut arg0.supply, 1000000000000000), arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun faucet_amount(arg0: &mut USDCSupply, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::from_balance<USDC>(0x2::balance::increase_supply<USDC>(&mut arg0.supply, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 6, b"USDC", b"usdc for test", b"The USDC coin for test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.circle.com/hubfs/Brand/USDC/USDC_icon_32x32.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDC>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v1);
        let v3 = USDCSupply{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<USDC>(v2),
            limits : 0x2::table::new<address, Limiter>(arg1),
            admins : 0x2::vec_set::empty<address>(),
        };
        0x2::vec_set::insert<address>(&mut v3.admins, @0x26cd92f73cc6b9879abec324b184ba4bf8c998672c30508bf56e9f8aba00a496);
        0x2::vec_set::insert<address>(&mut v3.admins, @0xd13a56990be8d4402a01b886d933c9969c2b526b818f2c732349b9d38d05e943);
        let v4 = InitEvent{
            sender   : 0x2::tx_context::sender(arg1),
            suplyID  : 0x2::object::id<USDCSupply>(&v3),
            decimals : 6,
        };
        0x2::event::emit<InitEvent>(v4);
        0x2::transfer::public_share_object<USDCSupply>(v3);
    }

    // decompiled from Move bytecode v6
}

