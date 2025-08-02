module 0x5635b3bb6addbc78d71b301101bb47cb0f868197c9d9c8de21656612cd58a12f::wager {
    struct WAGER has drop {
        dummy_field: bool,
    }

    struct Wager<phantom T0> has store, key {
        id: 0x2::object::UID,
        battle_id: 0x1::string::String,
        challenger: address,
        opponent: address,
        wager_amount: u64,
        challenger_balance: 0x2::balance::Balance<T0>,
        opponent_balance: 0x1::option::Option<0x2::balance::Balance<T0>>,
        is_active: bool,
    }

    struct WagerManager<phantom T0: store> has key {
        id: 0x2::object::UID,
        wagers: 0x2::table::Table<0x1::string::String, Wager<T0>>,
        admin: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun accept_wager<T0: store>(arg0: &mut WagerManager<T0>, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, Wager<T0>>(&arg0.wagers, v0), 1);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, Wager<T0>>(&mut arg0.wagers, v0);
        assert!(0x1::option::is_none<0x2::balance::Balance<T0>>(&v1.opponent_balance), 4);
        assert!(0x2::coin::value<T0>(&arg2) == v1.wager_amount, 3);
        0x1::option::fill<0x2::balance::Balance<T0>>(&mut v1.opponent_balance, 0x2::coin::into_balance<T0>(arg2));
        v1.opponent = 0x2::tx_context::sender(arg3);
        v1.is_active = true;
    }

    public fun cancel_wager<T0: store>(arg0: &mut WagerManager<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, Wager<T0>>(&arg0.wagers, v0), 1);
        let v1 = 0x2::table::borrow<0x1::string::String, Wager<T0>>(&arg0.wagers, v0);
        assert!(0x2::tx_context::sender(arg2) == v1.challenger, 5);
        assert!(!v1.is_active, 2);
        let Wager {
            id                 : v2,
            battle_id          : _,
            challenger         : v4,
            opponent           : _,
            wager_amount       : _,
            challenger_balance : v7,
            opponent_balance   : v8,
            is_active          : _,
        } = 0x2::table::remove<0x1::string::String, Wager<T0>>(&mut arg0.wagers, v0);
        0x1::option::destroy_none<0x2::balance::Balance<T0>>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v7, arg2), v4);
        0x2::object::delete(v2);
    }

    public fun create_wager<T0: store>(arg0: &mut WagerManager<T0>, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Wager<T0>{
            id                 : 0x2::object::new(arg3),
            battle_id          : 0x1::string::utf8(arg1),
            challenger         : 0x2::tx_context::sender(arg3),
            opponent           : @0x0,
            wager_amount       : 0x2::coin::value<T0>(&arg2),
            challenger_balance : 0x2::coin::into_balance<T0>(arg2),
            opponent_balance   : 0x1::option::none<0x2::balance::Balance<T0>>(),
            is_active          : false,
        };
        0x2::table::add<0x1::string::String, Wager<T0>>(&mut arg0.wagers, v0.battle_id, v0);
    }

    public fun create_wager_manager<T0: store>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WagerManager<T0>{
            id     : 0x2::object::new(arg1),
            wagers : 0x2::table::new<0x1::string::String, Wager<T0>>(arg1),
            admin  : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<WagerManager<T0>>(v0);
    }

    fun init(arg0: WAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun resolve_wager<T0: store>(arg0: &mut WagerManager<T0>, arg1: &AdminCap, arg2: vector<u8>, arg3: address, arg4: address, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 0);
        let v0 = 0x1::string::utf8(arg2);
        assert!(0x2::table::contains<0x1::string::String, Wager<T0>>(&arg0.wagers, v0), 1);
        let v1 = 0x2::table::remove<0x1::string::String, Wager<T0>>(&mut arg0.wagers, v0);
        assert!(v1.is_active, 2);
        let Wager {
            id                 : v2,
            battle_id          : _,
            challenger         : _,
            opponent           : _,
            wager_amount       : _,
            challenger_balance : v7,
            opponent_balance   : v8,
            is_active          : _,
        } = v1;
        let v10 = v7;
        0x2::balance::join<T0>(&mut v10, 0x1::option::destroy_some<0x2::balance::Balance<T0>>(v8));
        let v11 = 0x2::balance::value<T0>(&v10) * 5 / 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v10, v11), arg6), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v10, v11), arg6), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v10, arg6), arg3);
        0x2::object::delete(v2);
    }

    // decompiled from Move bytecode v6
}

