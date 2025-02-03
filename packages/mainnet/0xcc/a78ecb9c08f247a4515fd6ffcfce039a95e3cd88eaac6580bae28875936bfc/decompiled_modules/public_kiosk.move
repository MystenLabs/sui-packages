module 0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::public_kiosk {
    struct PUBLIC_KIOSK has drop {
        dummy_field: bool,
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

    struct KOrder has drop, store {
        order_id: u128,
        nft_id: 0x2::object::ID,
        owner: address,
        ord_price: u64,
        ord_state: u8,
    }

    public(friend) fun delist<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg3: &0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::checkVersion(arg2, 2);
        validatePair<T0, T1>(arg0);
        0x2::kiosk::delist<T0>(&mut arg0.kiosk, &arg0.ownerCap, arg1);
        let v0 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, KOrder>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 3001);
        v0.ord_state = 0;
    }

    public(friend) fun list<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: u64, arg3: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg4: &0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::checkVersion(arg3, 2);
        validatePair<T0, T1>(arg0);
        0x2::kiosk::list<T0>(&mut arg0.kiosk, &arg0.ownerCap, arg1, 0);
        let v0 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, KOrder>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg4), 3001);
        v0.ord_price = arg2;
        v0.ord_state = 1;
    }

    public(friend) fun place<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: T0, arg2: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg3: &0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::checkVersion(arg2, 2);
        validatePair<T0, T1>(arg0);
        let v0 = 0x2::object::id<T0>(&arg1);
        0x2::kiosk::place<T0>(&mut arg0.kiosk, &arg0.ownerCap, arg1);
        let v1 = KOrder{
            order_id  : 0,
            nft_id    : v0,
            owner     : 0x2::tx_context::sender(arg3),
            ord_price : 0,
            ord_state : 0,
        };
        0x2::dynamic_field::add<0x2::object::ID, KOrder>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), v0, v1);
    }

    public(friend) fun purchase<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg3: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>, KOrder) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::checkVersion(arg2, 2);
        validatePair<T0, T1>(arg0);
        0x2::tx_context::sender(arg3);
        let (v0, v1) = 0x2::kiosk::purchase<T0>(&mut arg0.kiosk, arg1, 0x2::coin::zero<0x2::sui::SUI>(arg3));
        (v0, v1, 0x2::dynamic_field::remove<0x2::object::ID, KOrder>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), arg1))
    }

    public(friend) fun take<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg3: &0x2::tx_context::TxContext) : u128 {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::checkVersion(arg2, 2);
        validatePair<T0, T1>(arg0);
        let v0 = 0x2::dynamic_field::remove<0x2::object::ID, KOrder>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg3), 3001);
        0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(&mut arg0.kiosk, &arg0.ownerCap, arg1), v0.owner);
        deleteOrder(v0)
    }

    public(friend) fun bindOrderId(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: u128) {
        0x2::dynamic_field::borrow_mut<0x2::object::ID, KOrder>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), arg1).order_id = arg2;
    }

    public(friend) fun createPublicKiosk<T0: store + key, T1>(arg0: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg1: &mut 0x2::tx_context::TxContext) : PublicKiosk {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::checkVersion(arg0, 2);
        let (v0, v1) = 0x2::kiosk::new(arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = PairKey{dummy_field: false};
        0x2::dynamic_field::add<PairKey, Pair>(0x2::kiosk::uid_mut_as_owner(&mut v3, &v2), v4, getPair<T0, T1>());
        PublicKiosk{
            kiosk    : v3,
            ownerCap : v2,
        }
    }

    fun deleteOrder(arg0: KOrder) : u128 {
        let KOrder {
            order_id  : v0,
            nft_id    : _,
            owner     : _,
            ord_price : _,
            ord_state : _,
        } = arg0;
        v0
    }

    public(friend) fun delistAndTake<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg3: &0x2::tx_context::TxContext) : u128 {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::checkVersion(arg2, 2);
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
    }

    public(friend) fun orderId(arg0: &KOrder) : u128 {
        arg0.order_id
    }

    public(friend) fun orderIdFromNft(arg0: &mut PublicKiosk, arg1: 0x2::object::ID) : u128 {
        0x2::dynamic_field::borrow_mut<0x2::object::ID, KOrder>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), arg1).order_id
    }

    public(friend) fun orderInfo(arg0: &KOrder) : (u128, 0x2::object::ID, address, u64) {
        (arg0.order_id, arg0.nft_id, arg0.owner, arg0.ord_price)
    }

    public(friend) fun orderOwner(arg0: &mut PublicKiosk, arg1: 0x2::object::ID) : address {
        0x2::dynamic_field::borrow_mut<0x2::object::ID, KOrder>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), arg1).owner
    }

    public(friend) fun orderPrice(arg0: &mut PublicKiosk, arg1: 0x2::object::ID) : u64 {
        let v0 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, KOrder>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), arg1);
        assert!(v0.ord_state >= 1, 3003);
        v0.ord_price
    }

    public(friend) fun placeAndList<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: T0, arg2: u64, arg3: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg4: &0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::checkVersion(arg3, 2);
        place<T0, T1>(arg0, arg1, arg3, arg4);
        list<T0, T1>(arg0, 0x2::object::id<T0>(&arg1), arg2, arg3, arg4);
    }

    public(friend) fun updatePrice<T0: store + key, T1>(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: u64, arg3: &0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::Version, arg4: &0x2::tx_context::TxContext) {
        0x97bd3876f24d934fa2f2b61673674eed9e8b0ae19f3ad148970e562e7a83703f::version::checkVersion(arg3, 2);
        validatePair<T0, T1>(arg0);
        let v0 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, KOrder>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), arg1);
        assert!(v0.owner == 0x2::tx_context::sender(arg4), 3001);
        assert!(v0.ord_state == 1, 3003);
        v0.ord_price = arg2;
    }

    fun validatePair<T0: store + key, T1>(arg0: &mut PublicKiosk) {
        let v0 = PairKey{dummy_field: false};
        assert!(*0x2::dynamic_field::borrow<PairKey, Pair>(0x2::kiosk::uid_mut_as_owner(&mut arg0.kiosk, &arg0.ownerCap), v0) == getPair<T0, T1>(), 3002);
    }

    // decompiled from Move bytecode v6
}

