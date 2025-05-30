module 0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::public_kiosk {
    struct PUBLIC_KIOSK has drop {
        dummy_field: bool,
    }

    struct OrderID has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct PublicKioskAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PairKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Pair has copy, drop, store {
        nft: 0x1::type_name::TypeName,
        token: 0x1::type_name::TypeName,
    }

    struct PublicKiosk has store {
        kiosk: 0x2::kiosk::Kiosk,
        ownerCap: 0x2::kiosk::KioskOwnerCap,
    }

    struct Order has drop, store {
        order_id: u128,
        nft_id: 0x2::object::ID,
        owner: address,
        ord_price: u64,
        ord_state: u8,
    }

    struct OrderEvent has copy, drop {
        order_id: u128,
        nft_id: 0x2::object::ID,
        action: u8,
        by: address,
        price: u64,
    }

    public(friend) fun delist<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: &0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::version::checkVersion(arg2, 1);
        validatePair<T0, T1>(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::kiosk::delist<T0>(&mut arg0.kiosk, &arg0.ownerCap, arg1);
        let v1 = OrderID{id: arg1};
        let v2 = 0x2::dynamic_field::borrow_mut<OrderID, Order>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), v1);
        assert!(v2.owner == v0, 3001);
        v2.ord_state = 0;
        0x2::event::emit<OrderEvent>(makeEvent(v2, 4, v2.ord_price, v0));
    }

    public(friend) fun list<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: u64, arg3: &0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::version::checkVersion(arg3, 1);
        validatePair<T0, T1>(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::kiosk::list<T0>(&mut arg0.kiosk, &arg0.ownerCap, arg1, 0);
        let v1 = OrderID{id: arg1};
        let v2 = 0x2::dynamic_field::borrow_mut<OrderID, Order>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), v1);
        assert!(v2.owner == v0, 3001);
        v2.ord_price = arg2;
        v2.ord_state = 1;
        0x2::event::emit<OrderEvent>(makeEvent(v2, 3, v2.ord_price, v0));
    }

    public(friend) fun place<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: T0, arg2: &0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::version::checkVersion(arg2, 1);
        validatePair<T0, T1>(arg0);
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = 0x2::tx_context::sender(arg3);
        0x2::kiosk::place<T0>(&mut arg0.kiosk, &arg0.ownerCap, arg1);
        let v2 = Order{
            order_id  : 0,
            nft_id    : v0,
            owner     : v1,
            ord_price : 0,
            ord_state : 0,
        };
        0x2::event::emit<OrderEvent>(makeEvent(&v2, 1, 0, v1));
        let v3 = OrderID{id: v0};
        0x2::dynamic_field::add<OrderID, Order>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), v3, v2);
    }

    public(friend) fun purchase<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: &0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::version::Version, arg3: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>, Order) {
        0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::version::checkVersion(arg2, 1);
        validatePair<T0, T1>(arg0);
        let (v0, v1) = 0x2::kiosk::purchase<T0>(&mut arg0.kiosk, arg1, 0x2::coin::zero<0x2::sui::SUI>(arg3));
        let v2 = OrderID{id: arg1};
        let v3 = 0x2::dynamic_field::remove<OrderID, Order>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), v2);
        0x2::event::emit<OrderEvent>(makeEvent(&v3, 5, v3.ord_price, 0x2::tx_context::sender(arg3)));
        (v0, v1, v3)
    }

    public(friend) fun take<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: &0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::version::Version, arg3: &mut 0x2::tx_context::TxContext) : u128 {
        0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::version::checkVersion(arg2, 1);
        validatePair<T0, T1>(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = OrderID{id: arg1};
        let v2 = 0x2::dynamic_field::remove<OrderID, Order>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), v1);
        assert!(v2.owner == v0, 3001);
        0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(&mut arg0.kiosk, &arg0.ownerCap, arg1), v2.owner);
        0x2::event::emit<OrderEvent>(makeEvent(&v2, 2, 0, v0));
        deleteOrder(v2)
    }

    public(friend) fun bindOrderId(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: u128) {
        let v0 = OrderID{id: arg1};
        0x2::dynamic_field::borrow_mut<OrderID, Order>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), v0).order_id = arg2;
    }

    public(friend) fun createPublicKiosk<T0: store + key, T1>(arg0: &PublicKioskAdminCap, arg1: &0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::version::Version, arg2: &mut 0x2::tx_context::TxContext) : PublicKiosk {
        0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::version::checkVersion(arg1, 1);
        let (v0, v1) = 0x2::kiosk::new(arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = PairKey{dummy_field: false};
        0x2::dynamic_field::add<PairKey, Pair>(0x2::kiosk::uid_mut_as_owner(&mut v3, &v2), v4, getPair<T0, T1>());
        PublicKiosk{
            kiosk    : v3,
            ownerCap : v2,
        }
    }

    fun deleteOrder(arg0: Order) : u128 {
        let Order {
            order_id  : v0,
            nft_id    : _,
            owner     : _,
            ord_price : _,
            ord_state : _,
        } = arg0;
        v0
    }

    public(friend) fun delistAndTake<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: &0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::version::Version, arg3: &mut 0x2::tx_context::TxContext) : u128 {
        0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::version::checkVersion(arg2, 1);
        delist<T0, T1>(arg0, arg1, arg2, arg3);
        take<T0, T1>(arg0, arg1, arg2, arg3)
    }

    fun getPair<T0: store + key, T1>() : Pair {
        Pair{
            nft   : 0x1::type_name::get<T0>(),
            token : 0x1::type_name::get<T1>(),
        }
    }

    fun init(arg0: PUBLIC_KIOSK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PublicKioskAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<PublicKioskAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    fun makeEvent(arg0: &Order, arg1: u8, arg2: u64, arg3: address) : OrderEvent {
        OrderEvent{
            order_id : arg0.order_id,
            nft_id   : arg0.nft_id,
            action   : arg1,
            by       : arg3,
            price    : arg2,
        }
    }

    public(friend) fun orderId(arg0: &Order) : u128 {
        arg0.order_id
    }

    public(friend) fun orderId2(arg0: &mut PublicKiosk, arg1: 0x2::object::ID) : u128 {
        let v0 = OrderID{id: arg1};
        0x2::dynamic_field::borrow_mut<OrderID, Order>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), v0).order_id
    }

    public(friend) fun orderInfo(arg0: &Order) : (u128, 0x2::object::ID, address, u64) {
        (arg0.order_id, arg0.nft_id, arg0.owner, arg0.ord_price)
    }

    public(friend) fun placeAndList<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: T0, arg2: u64, arg3: &0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::version::checkVersion(arg3, 1);
        place<T0, T1>(arg0, arg1, arg3, arg4);
        list<T0, T1>(arg0, 0x2::object::id<T0>(&arg1), arg2, arg3, arg4);
    }

    public(friend) fun replace<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: u64, arg3: &0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x47b17cfee22b84678d5992797cb5d4e89e099a8903290fede7518659f17bf80a::version::checkVersion(arg3, 1);
        validatePair<T0, T1>(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = OrderID{id: arg1};
        let v2 = 0x2::dynamic_field::borrow_mut<OrderID, Order>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), v1);
        assert!(v2.owner == v0, 3001);
        assert!(v2.ord_state == 1, 3003);
        v2.ord_price = arg2;
        0x2::event::emit<OrderEvent>(makeEvent(v2, 6, arg2, v0));
    }

    fun validatePair<T0: store + key, T1>(arg0: &mut PublicKiosk) {
        let v0 = PairKey{dummy_field: false};
        assert!(*0x2::dynamic_field::borrow<PairKey, Pair>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), v0) == getPair<T0, T1>(), 3002);
    }

    // decompiled from Move bytecode v6
}

