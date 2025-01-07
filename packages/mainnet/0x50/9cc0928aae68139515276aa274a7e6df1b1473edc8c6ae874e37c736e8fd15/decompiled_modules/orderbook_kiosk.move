module 0x509cc0928aae68139515276aa274a7e6df1b1473edc8c6ae874e37c736e8fd15::orderbook_kiosk {
    struct EventCreated has copy, drop {
        orderbook_id: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
    }

    struct EventListed has copy, drop {
        object_id: 0x2::object::ID,
        orderbook_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
        price: u64,
    }

    struct EventDelisted has copy, drop {
        object_id: 0x2::object::ID,
        orderbook_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
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
        source_kiosk_id: 0x2::object::ID,
        target_kiosk_id: 0x2::object::ID,
        type_name: 0x1::type_name::TypeName,
        price: u64,
    }

    struct OrderbookKiosk<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        inner: 0x509cc0928aae68139515276aa274a7e6df1b1473edc8c6ae874e37c736e8fd15::orderbook_raw::OrderbookRaw<0x2::kiosk::PurchaseCap<T0>>,
        version: u64,
    }

    public fun new<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : OrderbookKiosk<T0> {
        assert!(0x2::package::from_package<T0>(arg0), 1);
        let v0 = OrderbookKiosk<T0>{
            id      : 0x2::object::new(arg1),
            inner   : 0x509cc0928aae68139515276aa274a7e6df1b1473edc8c6ae874e37c736e8fd15::orderbook_raw::new<0x2::kiosk::PurchaseCap<T0>>(arg1),
            version : 0,
        };
        let v1 = EventCreated{
            orderbook_id : 0x2::object::id<OrderbookKiosk<T0>>(&v0),
            type_name    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<EventCreated>(v1);
        v0
    }

    fun assert_version<T0: store + key>(arg0: &OrderbookKiosk<T0>) {
        assert!(arg0.version == 0, 0);
    }

    fun assert_version_and_upgrade<T0: store + key>(arg0: &mut OrderbookKiosk<T0>) {
        if (arg0.version < 0) {
            arg0.version = 0;
        };
        assert_version<T0>(arg0);
    }

    public fun buy<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut OrderbookKiosk<T0>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        assert_version_and_upgrade<T0>(arg1);
        assert!(0x2::kiosk::kiosk_owner_cap_for(arg4) == 0x2::object::id<0x2::kiosk::Kiosk>(arg3), 2);
        let (v0, v1, _, v3) = 0x509cc0928aae68139515276aa274a7e6df1b1473edc8c6ae874e37c736e8fd15::orderbook_raw::buy<0x2::kiosk::PurchaseCap<T0>>(&mut arg1.inner, arg5, arg6);
        let (v4, v5) = 0x2::kiosk::purchase_with_cap<T0>(arg2, v0, 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg7));
        let v6 = v5;
        0x509cc0928aae68139515276aa274a7e6df1b1473edc8c6ae874e37c736e8fd15::orderbook_rule::prove<T0>(arg0, &mut v6);
        let v7 = EventTrade{
            object_id       : arg5,
            orderbook_id    : 0x2::object::id<OrderbookKiosk<T0>>(arg1),
            source_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            target_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            type_name       : 0x1::type_name::get<T0>(),
            price           : v3,
        };
        0x2::event::emit<EventTrade>(v7);
        (v4, v6)
    }

    public entry fun claim<T0: store + key>(arg0: &mut OrderbookKiosk<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x509cc0928aae68139515276aa274a7e6df1b1473edc8c6ae874e37c736e8fd15::orderbook_raw::claim<0x2::kiosk::PurchaseCap<T0>>(&mut arg0.inner, arg1), arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun delist<T0: store + key>(arg0: &mut OrderbookKiosk<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade<T0>(arg0);
        0x2::kiosk::return_purchase_cap<T0>(arg1, 0x509cc0928aae68139515276aa274a7e6df1b1473edc8c6ae874e37c736e8fd15::orderbook_raw::delist<0x2::kiosk::PurchaseCap<T0>>(&mut arg0.inner, arg2, arg3));
        let v0 = EventDelisted{
            object_id    : arg2,
            orderbook_id : 0x2::object::id<OrderbookKiosk<T0>>(arg0),
            kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            type_name    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<EventDelisted>(v0);
    }

    public entry fun list<T0: store + key>(arg0: &mut OrderbookKiosk<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        list_inner<T0>(arg0, arg1, arg2, arg3, arg4, 0x1::option::none<0x509cc0928aae68139515276aa274a7e6df1b1473edc8c6ae874e37c736e8fd15::orderbook_raw::Commission>(), arg5);
    }

    fun list_inner<T0: store + key>(arg0: &mut OrderbookKiosk<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: 0x1::option::Option<0x509cc0928aae68139515276aa274a7e6df1b1473edc8c6ae874e37c736e8fd15::orderbook_raw::Commission>, arg6: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade<T0>(arg0);
        0x509cc0928aae68139515276aa274a7e6df1b1473edc8c6ae874e37c736e8fd15::orderbook_raw::list<0x2::kiosk::PurchaseCap<T0>>(&mut arg0.inner, arg3, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg6), arg4, arg5, arg6);
        let v0 = EventListed{
            object_id    : arg3,
            orderbook_id : 0x2::object::id<OrderbookKiosk<T0>>(arg0),
            kiosk_id     : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            type_name    : 0x1::type_name::get<T0>(),
            price        : arg4,
        };
        0x2::event::emit<EventListed>(v0);
    }

    public entry fun list_with_commission<T0: store + key>(arg0: &mut OrderbookKiosk<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        list_inner<T0>(arg0, arg1, arg2, arg3, arg4, 0x1::option::some<0x509cc0928aae68139515276aa274a7e6df1b1473edc8c6ae874e37c736e8fd15::orderbook_raw::Commission>(0x509cc0928aae68139515276aa274a7e6df1b1473edc8c6ae874e37c736e8fd15::orderbook_raw::new_commission(arg5, arg6)), arg7);
    }

    public entry fun modify<T0: store + key>(arg0: &mut OrderbookKiosk<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        modify_inner<T0>(arg0, arg1, arg2, 0x1::option::none<0x509cc0928aae68139515276aa274a7e6df1b1473edc8c6ae874e37c736e8fd15::orderbook_raw::Commission>(), arg3);
    }

    fun modify_inner<T0: store + key>(arg0: &mut OrderbookKiosk<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::option::Option<0x509cc0928aae68139515276aa274a7e6df1b1473edc8c6ae874e37c736e8fd15::orderbook_raw::Commission>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade<T0>(arg0);
        0x509cc0928aae68139515276aa274a7e6df1b1473edc8c6ae874e37c736e8fd15::orderbook_raw::modify<0x2::kiosk::PurchaseCap<T0>>(&mut arg0.inner, arg1, arg2, arg3, arg4);
        let v0 = EventModified{
            object_id    : arg1,
            orderbook_id : 0x2::object::id<OrderbookKiosk<T0>>(arg0),
            type_name    : 0x1::type_name::get<T0>(),
            price        : arg2,
        };
        0x2::event::emit<EventModified>(v0);
    }

    public entry fun modify_with_commission<T0: store + key>(arg0: &mut OrderbookKiosk<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        modify_inner<T0>(arg0, arg1, arg2, 0x1::option::some<0x509cc0928aae68139515276aa274a7e6df1b1473edc8c6ae874e37c736e8fd15::orderbook_raw::Commission>(0x509cc0928aae68139515276aa274a7e6df1b1473edc8c6ae874e37c736e8fd15::orderbook_raw::new_commission(arg3, arg4)), arg5);
    }

    // decompiled from Move bytecode v6
}

