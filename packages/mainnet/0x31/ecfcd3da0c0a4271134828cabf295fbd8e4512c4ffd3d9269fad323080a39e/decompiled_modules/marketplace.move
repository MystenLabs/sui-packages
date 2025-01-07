module 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::marketplace {
    struct Marketplace<phantom T0> has key {
        id: 0x2::object::UID,
        fee_percent: u64,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        ask: u64,
        owner: address,
    }

    public fun buy<T0: store + key>(arg0: &mut Marketplace<T0>, arg1: &mut 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::store::StoreHub, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : T0 {
        let Listing {
            id    : v0,
            ask   : v1,
            owner : v2,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg2);
        let v3 = v0;
        handle_payment<T0>(arg0, arg1, arg3, v2, v1, arg4);
        0x2::object::delete(v3);
        0x2::dynamic_object_field::remove<bool, T0>(&mut v3, true)
    }

    public entry fun buy_and_take<T0: store + key>(arg0: &mut Marketplace<T0>, arg1: &mut 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::store::StoreHub, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = buy<T0>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg4));
    }

    fun check_fee_percent(arg0: u64) {
        assert!(arg0 <= 100, 2);
    }

    public entry fun create_marketplace<T0>(arg0: &0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        publish_marketplace<T0>(arg1, arg2);
    }

    public fun delist<T0: store + key>(arg0: &mut Marketplace<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let Listing {
            id    : v0,
            ask   : _,
            owner : v2,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v3 = v0;
        assert!(0x2::tx_context::sender(arg2) == v2, 1);
        0x2::object::delete(v3);
        0x2::dynamic_object_field::remove<bool, T0>(&mut v3, true)
    }

    public entry fun delist_and_take<T0: store + key>(arg0: &mut Marketplace<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = delist<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun get_fee_percent<T0>(arg0: &Marketplace<T0>) : u64 {
        arg0.fee_percent
    }

    fun handle_payment<T0>(arg0: &mut Marketplace<T0>, arg1: &mut 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::store::StoreHub, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::get_value_percentage(arg4, arg0.fee_percent);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= arg4 + v0, 0);
        0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::store::replenish_balance(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, arg4, arg5), arg3);
        0x2::pay::keep<0x2::sui::SUI>(arg2, arg5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        publish_marketplace<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::suimo::Suimo>(3, arg0);
        publish_marketplace<0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::item::Item>(3, arg0);
    }

    public entry fun list<T0: store + key>(arg0: &mut Marketplace<T0>, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Listing{
            id    : 0x2::object::new(arg3),
            ask   : arg2,
            owner : 0x2::tx_context::sender(arg3),
        };
        0x2::dynamic_object_field::add<bool, T0>(&mut v0.id, true, arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut arg0.id, 0x2::object::id<T0>(&arg1), v0);
    }

    fun publish_marketplace<T0>(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        check_fee_percent(arg0);
        let v0 = Marketplace<T0>{
            id          : 0x2::object::new(arg1),
            fee_percent : arg0,
        };
        0x2::transfer::share_object<Marketplace<T0>>(v0);
    }

    public entry fun set_fee_percent<T0>(arg0: &0x31ecfcd3da0c0a4271134828cabf295fbd8e4512c4ffd3d9269fad323080a39e::utils::AdminCap, arg1: &mut Marketplace<T0>, arg2: u64) {
        check_fee_percent(arg2);
        arg1.fee_percent = arg2;
    }

    // decompiled from Move bytecode v6
}

