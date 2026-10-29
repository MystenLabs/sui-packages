module 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::pocket {
    struct ConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Config has store {
        open: bool,
    }

    struct ItemKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct CoinKey has copy, drop, store {
        coin: 0x1::type_name::TypeName,
    }

    struct CountKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PocketSet has copy, drop {
        collection: 0x2::object::ID,
        open: bool,
    }

    struct PocketChanged has copy, drop {
        grave: 0x2::object::ID,
        by: address,
        action: u8,
        what: 0x1::type_name::TypeName,
        item: 0x1::option::Option<0x2::object::ID>,
        amount: u64,
    }

    public fun balance<T0>(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem) : u64 {
        let v0 = CoinKey{coin: 0x1::type_name::with_original_ids<T0>()};
        if (!0x2::dynamic_field::exists<CoinKey>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid(arg0), v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<CoinKey, 0x2::balance::Balance<T0>>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid(arg0), v0))
    }

    public fun accept<T0: store + key>(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg1: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem, arg2: 0x2::transfer::Receiving<T0>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::transfer::public_receive<T0>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid_mut(arg1), arg2);
        stash<T0>(arg0, arg1, v0, arg3);
    }

    public fun accept_coin<T0>(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg1: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid_mut(arg1), arg2));
        pour<T0>(arg0, arg1, v0, arg3);
    }

    public fun accept_funds<T0>(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg1: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid_mut(arg1), arg2));
        pour<T0>(arg0, arg1, v0, arg3);
    }

    fun assert_can_fill(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection) {
        0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::check_current(arg0);
        assert!(is_open(arg0), 200);
    }

    fun changed(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem, arg1: &0x2::tx_context::TxContext, arg2: u8, arg3: 0x1::type_name::TypeName, arg4: 0x1::option::Option<0x2::object::ID>, arg5: u64) {
        let v0 = PocketChanged{
            grave  : 0x2::object::id<0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem>(arg0),
            by     : 0x2::tx_context::sender(arg1),
            action : arg2,
            what   : arg3,
            item   : arg4,
            amount : arg5,
        };
        0x2::event::emit<PocketChanged>(v0);
    }

    fun count(arg0: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem, arg1: bool) {
        let v0 = 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid_mut(arg0);
        let v1 = CountKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<CountKey>(v0, v1)) {
            let v2 = CountKey{dummy_field: false};
            0x2::dynamic_field::add<CountKey, u64>(v0, v2, 0);
        };
        let v3 = CountKey{dummy_field: false};
        let v4 = 0x2::dynamic_field::borrow_mut<CountKey, u64>(v0, v3);
        if (arg1) {
            assert!(*v4 < 64, 202);
            *v4 = *v4 + 1;
        } else {
            *v4 = *v4 - 1;
        };
    }

    public fun deposit<T0>(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg1: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert_can_fill(arg0);
        let v0 = CoinKey{coin: 0x1::type_name::with_original_ids<T0>()};
        if (0x2::dynamic_field::exists<CoinKey>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid(arg1), v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<CoinKey, 0x2::balance::Balance<T0>>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid_mut(arg1), v0), 0x2::coin::into_balance<T0>(arg2));
        } else {
            count(arg1, true);
            0x2::dynamic_field::add<CoinKey, 0x2::balance::Balance<T0>>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid_mut(arg1), v0, 0x2::coin::into_balance<T0>(arg2));
        };
        changed(arg1, arg3, 2, v0.coin, 0x1::option::none<0x2::object::ID>(), 0x2::coin::value<T0>(&arg2));
    }

    public fun holds(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem, arg1: 0x2::object::ID) : bool {
        let v0 = ItemKey{id: arg1};
        0x2::dynamic_object_field::exists<ItemKey>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid(arg0), v0)
    }

    public fun is_open(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection) : bool {
        let v0 = 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::collection_uid(arg0);
        let v1 = ConfigKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<ConfigKey>(v0, v1)) {
            return true
        };
        let v2 = ConfigKey{dummy_field: false};
        0x2::dynamic_field::borrow<ConfigKey, Config>(v0, v2).open
    }

    fun pour<T0>(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg1: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::tx_context::TxContext) {
        assert_can_fill(arg0);
        let v0 = CoinKey{coin: 0x1::type_name::with_original_ids<T0>()};
        if (0x2::dynamic_field::exists<CoinKey>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid(arg1), v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<CoinKey, 0x2::balance::Balance<T0>>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid_mut(arg1), v0), arg2);
        } else {
            count(arg1, true);
            0x2::dynamic_field::add<CoinKey, 0x2::balance::Balance<T0>>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid_mut(arg1), v0, arg2);
        };
        changed(arg1, arg3, 4, v0.coin, 0x1::option::none<0x2::object::ID>(), 0x2::balance::value<T0>(&arg2));
    }

    public fun put<T0: store + key>(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg1: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem, arg2: T0, arg3: &0x2::tx_context::TxContext) {
        assert_can_fill(arg0);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(v0 != 0x1::type_name::with_original_ids<0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem>(), 203);
        assert!(v0 != 0x1::type_name::with_original_ids<0x2::kiosk::KioskOwnerCap>(), 204);
        assert!(v0 != 0x1::type_name::with_original_ids<0x2::kiosk::Kiosk>(), 204);
        let v1 = 0x2::object::id<T0>(&arg2);
        count(arg1, true);
        let v2 = ItemKey{id: v1};
        0x2::dynamic_object_field::add<ItemKey, T0>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid_mut(arg1), v2, arg2);
        changed(arg1, arg3, 0, v0, 0x1::option::some<0x2::object::ID>(v1), 1);
    }

    public fun receive<T0: store + key>(arg0: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem, arg1: 0x2::transfer::Receiving<T0>, arg2: &0x2::tx_context::TxContext) : T0 {
        refuse_carriers(0x1::type_name::with_original_ids<T0>());
        let v0 = 0x2::transfer::public_receive<T0>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid_mut(arg0), arg1);
        changed(arg0, arg2, 5, 0x1::type_name::with_original_ids<T0>(), 0x1::option::some<0x2::object::ID>(0x2::object::id<T0>(&v0)), 1);
        v0
    }

    fun refuse_carriers(arg0: 0x1::type_name::TypeName) {
        assert!(arg0 != 0x1::type_name::with_original_ids<0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem>(), 203);
        assert!(arg0 != 0x1::type_name::with_original_ids<0x2::kiosk::KioskOwnerCap>(), 204);
        assert!(arg0 != 0x1::type_name::with_original_ids<0x2::kiosk::Kiosk>(), 204);
    }

    entry fun set_pocket(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::AdminCap, arg1: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg2: bool) {
        0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::check_admin(arg0, arg1);
        let v0 = 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::collection_uid_mut(arg1);
        let v1 = ConfigKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ConfigKey>(v0, v1)) {
            let v2 = ConfigKey{dummy_field: false};
            0x2::dynamic_field::borrow_mut<ConfigKey, Config>(v0, v2).open = arg2;
        } else {
            let v3 = ConfigKey{dummy_field: false};
            let v4 = Config{open: arg2};
            0x2::dynamic_field::add<ConfigKey, Config>(v0, v3, v4);
        };
        let v5 = PocketSet{
            collection : 0x2::object::id<0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection>(arg1),
            open       : arg2,
        };
        0x2::event::emit<PocketSet>(v5);
    }

    fun stash<T0: store + key>(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Collection, arg1: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem, arg2: T0, arg3: &0x2::tx_context::TxContext) {
        assert_can_fill(arg0);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        refuse_carriers(v0);
        let v1 = 0x2::object::id<T0>(&arg2);
        count(arg1, true);
        let v2 = ItemKey{id: v1};
        0x2::dynamic_object_field::add<ItemKey, T0>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid_mut(arg1), v2, arg2);
        changed(arg1, arg3, 4, v0, 0x1::option::some<0x2::object::ID>(v1), 1);
    }

    public fun take<T0: store + key>(arg0: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : T0 {
        let v0 = 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid_mut(arg0);
        let v1 = ItemKey{id: arg1};
        assert!(0x2::dynamic_object_field::exists_with_type<ItemKey, T0>(v0, v1), 201);
        let v2 = ItemKey{id: arg1};
        count(arg0, false);
        changed(arg0, arg2, 1, 0x1::type_name::with_original_ids<T0>(), 0x1::option::some<0x2::object::ID>(arg1), 1);
        0x2::dynamic_object_field::remove<ItemKey, T0>(v0, v2)
    }

    public fun things(arg0: &0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem) : u64 {
        let v0 = 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid(arg0);
        let v1 = CountKey{dummy_field: false};
        if (0x2::dynamic_field::exists<CountKey>(v0, v1)) {
            let v3 = CountKey{dummy_field: false};
            *0x2::dynamic_field::borrow<CountKey, u64>(v0, v3)
        } else {
            0
        }
    }

    public fun withdraw<T0>(arg0: &mut 0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::Mortem, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = CoinKey{coin: 0x1::type_name::with_original_ids<T0>()};
        assert!(0x2::dynamic_field::exists<CoinKey>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid(arg0), v0), 201);
        let v1 = 0x2::dynamic_field::borrow_mut<CoinKey, 0x2::balance::Balance<T0>>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid_mut(arg0), v0);
        assert!(0x2::balance::value<T0>(v1) >= arg1, 201);
        if (0x2::balance::value<T0>(v1) == 0) {
            0x2::balance::destroy_zero<T0>(0x2::dynamic_field::remove<CoinKey, 0x2::balance::Balance<T0>>(0xee0e96c6dcfa447bd5e026be5c995fca0c058e12530c8b5dfef57aa390c8d45f::collection::grave_uid_mut(arg0), v0));
            count(arg0, false);
        };
        changed(arg0, arg2, 3, v0.coin, 0x1::option::none<0x2::object::ID>(), arg1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, arg1), arg2)
    }

    // decompiled from Move bytecode v7
}

