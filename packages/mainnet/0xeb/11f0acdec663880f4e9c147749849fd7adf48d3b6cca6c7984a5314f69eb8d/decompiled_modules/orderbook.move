module 0xeb11f0acdec663880f4e9c147749849fd7adf48d3b6cca6c7984a5314f69eb8d::orderbook {
    struct EventCreated has copy, drop {
        orderbook_id: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
    }

    struct EventListed has copy, drop {
        object_id: 0x2::object::ID,
        orderbook_id: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
        price: u64,
    }

    struct EventDelisted has copy, drop {
        object_id: 0x2::object::ID,
        orderbook_id: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
    }

    struct EventModified has copy, drop {
        object_id: 0x2::object::ID,
        orderbook_id: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
        price: u64,
    }

    struct EventTrade has copy, drop {
        object_id: 0x2::object::ID,
        orderbook_id: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
        price: u64,
    }

    struct Orderbook<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        inner: 0xeb11f0acdec663880f4e9c147749849fd7adf48d3b6cca6c7984a5314f69eb8d::orderbook_raw::OrderbookRaw<T0>,
        version: u64,
    }

    struct OrderbookRule {
        dummy_field: bool,
    }

    public fun new<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : Orderbook<T0> {
        assert!(0x2::package::from_package<T0>(arg0), 1);
        let v0 = Orderbook<T0>{
            id      : 0x2::object::new(arg1),
            inner   : 0xeb11f0acdec663880f4e9c147749849fd7adf48d3b6cca6c7984a5314f69eb8d::orderbook_raw::new<T0>(arg1),
            version : 0,
        };
        let v1 = EventCreated{
            orderbook_id : 0x2::object::id<Orderbook<T0>>(&v0),
            type_name    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<EventCreated>(v1);
        v0
    }

    fun assert_version<T0: store + key>(arg0: &Orderbook<T0>) {
        assert!(arg0.version == 0, 0);
    }

    fun assert_version_and_upgrade<T0: store + key>(arg0: &mut Orderbook<T0>) {
        if (arg0.version < 0) {
            arg0.version = 0;
        };
        assert_version<T0>(arg0);
    }

    public fun buy<T0: store + key>(arg0: &mut Orderbook<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        assert_version_and_upgrade<T0>(arg0);
        let (v0, v1, v2, v3) = 0xeb11f0acdec663880f4e9c147749849fd7adf48d3b6cca6c7984a5314f69eb8d::orderbook_raw::buy<T0>(&mut arg0.inner, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg3), v2);
        let v4 = EventTrade{
            object_id    : arg1,
            orderbook_id : 0x2::object::id<Orderbook<T0>>(arg0),
            type_name    : 0x1::type_name::get<T0>(),
            price        : v3,
        };
        0x2::event::emit<EventTrade>(v4);
        v0
    }

    public fun claim_commission<T0: store + key>(arg0: &mut Orderbook<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0xeb11f0acdec663880f4e9c147749849fd7adf48d3b6cca6c7984a5314f69eb8d::orderbook_raw::claim_commission<T0>(&mut arg0.inner, arg1)
    }

    public fun delist<T0: store + key>(arg0: &mut Orderbook<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        assert_version_and_upgrade<T0>(arg0);
        let v0 = EventDelisted{
            object_id    : arg1,
            orderbook_id : 0x2::object::id<Orderbook<T0>>(arg0),
            type_name    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<EventDelisted>(v0);
        0xeb11f0acdec663880f4e9c147749849fd7adf48d3b6cca6c7984a5314f69eb8d::orderbook_raw::delist<T0>(&mut arg0.inner, arg1, arg2)
    }

    public entry fun distribute_commission<T0: store + key>(arg0: &mut Orderbook<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_commission<T0>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun list<T0: store + key>(arg0: &mut Orderbook<T0>, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        list_inner<T0>(arg0, arg1, arg2, 0x1::option::none<0xeb11f0acdec663880f4e9c147749849fd7adf48d3b6cca6c7984a5314f69eb8d::orderbook_raw::Commission>(), arg3);
    }

    fun list_inner<T0: store + key>(arg0: &mut Orderbook<T0>, arg1: T0, arg2: u64, arg3: 0x1::option::Option<0xeb11f0acdec663880f4e9c147749849fd7adf48d3b6cca6c7984a5314f69eb8d::orderbook_raw::Commission>, arg4: &0x2::tx_context::TxContext) {
        assert_version_and_upgrade<T0>(arg0);
        let v0 = 0x2::object::id<T0>(&arg1);
        0xeb11f0acdec663880f4e9c147749849fd7adf48d3b6cca6c7984a5314f69eb8d::orderbook_raw::list<T0>(&mut arg0.inner, v0, arg1, arg2, arg3, arg4);
        let v1 = EventListed{
            object_id    : v0,
            orderbook_id : 0x2::object::id<Orderbook<T0>>(arg0),
            type_name    : 0x1::type_name::get<T0>(),
            price        : arg2,
        };
        0x2::event::emit<EventListed>(v1);
    }

    public entry fun list_with_commission<T0: store + key>(arg0: &mut Orderbook<T0>, arg1: T0, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        list_inner<T0>(arg0, arg1, arg2, 0x1::option::some<0xeb11f0acdec663880f4e9c147749849fd7adf48d3b6cca6c7984a5314f69eb8d::orderbook_raw::Commission>(0xeb11f0acdec663880f4e9c147749849fd7adf48d3b6cca6c7984a5314f69eb8d::orderbook_raw::new_commission(arg3, arg4)), arg5);
    }

    public entry fun modify<T0: store + key>(arg0: &mut Orderbook<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        modify_inner<T0>(arg0, arg1, arg2, 0x1::option::none<0xeb11f0acdec663880f4e9c147749849fd7adf48d3b6cca6c7984a5314f69eb8d::orderbook_raw::Commission>(), arg3);
    }

    fun modify_inner<T0: store + key>(arg0: &mut Orderbook<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::option::Option<0xeb11f0acdec663880f4e9c147749849fd7adf48d3b6cca6c7984a5314f69eb8d::orderbook_raw::Commission>, arg4: &0x2::tx_context::TxContext) {
        assert_version_and_upgrade<T0>(arg0);
        0xeb11f0acdec663880f4e9c147749849fd7adf48d3b6cca6c7984a5314f69eb8d::orderbook_raw::modify<T0>(&mut arg0.inner, arg1, arg2, arg3, arg4);
        let v0 = EventModified{
            object_id    : arg1,
            orderbook_id : 0x2::object::id<Orderbook<T0>>(arg0),
            type_name    : 0x1::type_name::get<T0>(),
            price        : arg2,
        };
        0x2::event::emit<EventModified>(v0);
    }

    public entry fun modify_with_commission<T0: store + key>(arg0: &mut Orderbook<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        modify_inner<T0>(arg0, arg1, arg2, 0x1::option::some<0xeb11f0acdec663880f4e9c147749849fd7adf48d3b6cca6c7984a5314f69eb8d::orderbook_raw::Commission>(0xeb11f0acdec663880f4e9c147749849fd7adf48d3b6cca6c7984a5314f69eb8d::orderbook_raw::new_commission(arg3, arg4)), arg5);
    }

    // decompiled from Move bytecode v6
}

