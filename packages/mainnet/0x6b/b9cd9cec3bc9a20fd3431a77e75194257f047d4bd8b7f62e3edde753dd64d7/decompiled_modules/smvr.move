module 0x6bb9cd9cec3bc9a20fd3431a77e75194257f047d4bd8b7f62e3edde753dd64d7::smvr {
    struct SmvrManager has store, key {
        id: 0x2::object::UID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<SMVR>,
        coin_metadata: 0x2::coin::CoinMetadata<SMVR>,
    }

    struct SMVR has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &SmvrManager, arg1: &mut Registry, arg2: 0x2::coin::Coin<SMVR>) : u64 {
        0x2::coin::burn<SMVR>(&mut arg1.treasury_cap, arg2)
    }

    public fun mint(arg0: &SmvrManager, arg1: &mut Registry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SMVR> {
        assert!(arg2 <= 666666666666666666 - 0x2::coin::total_supply<SMVR>(&arg1.treasury_cap), 0);
        0x2::coin::mint<SMVR>(&mut arg1.treasury_cap, arg2, arg3)
    }

    entry fun update_icon_url(arg0: &SmvrManager, arg1: &mut Registry, arg2: vector<u8>) {
        0x2::coin::update_icon_url<SMVR>(&arg1.treasury_cap, &mut arg1.coin_metadata, 0x1::ascii::string(arg2));
    }

    fun init(arg0: SMVR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMVR>(arg0, 9, b"SMVR", b"Sui Mover Token", b"Fake Sui Mover token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/Typus-Lab/suimover-unittest-example/main/mover_token/SMVR.svg")), arg1);
        let v2 = Registry{
            id            : 0x2::object::new(arg1),
            treasury_cap  : v0,
            coin_metadata : v1,
        };
        let v3 = SmvrManager{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<SmvrManager>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Registry>(v2);
    }

    entry fun issue_manager_for_user(arg0: &SmvrManager, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SmvrManager{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<SmvrManager>(v0, arg1);
    }

    entry fun mint_and_stake(arg0: &mut Registry, arg1: &mut 0x6bb9cd9cec3bc9a20fd3431a77e75194257f047d4bd8b7f62e3edde753dd64d7::pool::Pool, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2) / 100;
        assert!(v0 <= 666666666666666666 - 0x2::coin::total_supply<SMVR>(&arg0.treasury_cap), 0);
        0x6bb9cd9cec3bc9a20fd3431a77e75194257f047d4bd8b7f62e3edde753dd64d7::pool::stake<SMVR>(arg1, 0x2::coin::mint<SMVR>(&mut arg0.treasury_cap, v0, arg4), arg3, arg4);
        store_coin<0x2::sui::SUI>(arg0, arg2);
    }

    fun store_coin<T0>(arg0: &mut Registry, arg1: 0x2::coin::Coin<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg1));
        } else {
            0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, 0x2::coin::into_balance<T0>(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

