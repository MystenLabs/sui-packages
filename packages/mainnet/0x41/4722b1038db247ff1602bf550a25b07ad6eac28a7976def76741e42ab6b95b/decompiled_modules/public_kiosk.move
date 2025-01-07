module 0x414722b1038db247ff1602bf550a25b07ad6eac28a7976def76741e42ab6b95b::public_kiosk {
    struct PUBLIC_KIOSK has drop {
        dummy_field: bool,
    }

    struct KioskVault has store, key {
        id: 0x2::object::UID,
        ownerCap: 0x2::kiosk::KioskOwnerCap,
    }

    struct OrderID has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct PKAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Order has drop, store {
        id: 0x2::object::ID,
        owner: address,
        order_type: u8,
        price: u64,
        state: u8,
    }

    struct AssetPairName has copy, drop, store {
        dummy_field: bool,
    }

    struct AssetPair has copy, drop, store {
        nft: 0x1::type_name::TypeName,
        token: 0x1::type_name::TypeName,
    }

    struct OrderPlaced has copy, drop {
        nft_id: 0x2::object::ID,
        kiosk: 0x2::object::ID,
        vault: 0x2::object::ID,
        by: address,
        nft_type: 0x1::type_name::TypeName,
        token_type: 0x1::type_name::TypeName,
    }

    struct OrderListed has copy, drop {
        nft_id: 0x2::object::ID,
        kiosk: 0x2::object::ID,
        vault: 0x2::object::ID,
        by: address,
        nft_type: 0x1::type_name::TypeName,
        token_type: 0x1::type_name::TypeName,
        price: u64,
    }

    struct OrderPurchased has copy, drop {
        nft_id: 0x2::object::ID,
        kiosk: 0x2::object::ID,
        vault: 0x2::object::ID,
        nft_type: 0x1::type_name::TypeName,
        token_type: 0x1::type_name::TypeName,
        price: u64,
        match_price: u64,
        by: address,
    }

    struct PublicKioskCreated has copy, drop {
        by: address,
        nft: 0x1::type_name::TypeName,
        token: 0x1::type_name::TypeName,
        id: 0x2::object::ID,
        vaultId: 0x2::object::ID,
    }

    public fun list<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut KioskVault, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = AssetPairName{dummy_field: false};
        let v1 = *0x2::dynamic_field::borrow<AssetPairName, AssetPair>(0x2::kiosk::uid_mut_as_owner(arg0, &arg1.ownerCap), v0);
        assert!(0x1::type_name::get<T0>() == v1.nft && 0x1::type_name::get<T1>() == v1.token, 4002);
        0x2::kiosk::list<T0>(arg0, &arg1.ownerCap, arg2, 0);
        let v2 = OrderID{id: arg2};
        let v3 = 0x2::dynamic_field::borrow_mut<OrderID, Order>(0x2::kiosk::uid_mut_as_owner(arg0, &arg1.ownerCap), v2);
        assert!(v3.owner == 0x2::tx_context::sender(arg4), 4001);
        v3.price = arg3;
        v3.state = 1;
        let v4 = OrderListed{
            nft_id     : arg2,
            kiosk      : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            vault      : 0x2::object::id<KioskVault>(arg1),
            by         : 0x2::tx_context::sender(arg4),
            nft_type   : v1.nft,
            token_type : v1.token,
            price      : arg3,
        };
        0x2::event::emit<OrderListed>(v4);
    }

    public fun place<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut KioskVault, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = AssetPairName{dummy_field: false};
        let v1 = *0x2::dynamic_field::borrow<AssetPairName, AssetPair>(0x2::kiosk::uid_mut_as_owner(arg0, &arg1.ownerCap), v0);
        assert!(0x1::type_name::get<T0>() == v1.nft && 0x1::type_name::get<T1>() == v1.token, 4002);
        let v2 = 0x2::object::id<T0>(&arg2);
        0x2::kiosk::place<T0>(arg0, &arg1.ownerCap, arg2);
        let v3 = Order{
            id         : v2,
            owner      : 0x2::tx_context::sender(arg3),
            order_type : 0,
            price      : 0,
            state      : 0,
        };
        let v4 = OrderID{id: v2};
        0x2::dynamic_field::add<OrderID, Order>(0x2::kiosk::uid_mut_as_owner(arg0, &arg1.ownerCap), v4, v3);
        let v5 = OrderPlaced{
            nft_id     : v2,
            kiosk      : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            vault      : 0x2::object::id<KioskVault>(arg1),
            by         : 0x2::tx_context::sender(arg3),
            nft_type   : v1.nft,
            token_type : v1.token,
        };
        0x2::event::emit<OrderPlaced>(v5);
    }

    public fun purchase<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut KioskVault, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>, Order) {
        let v0 = AssetPairName{dummy_field: false};
        let v1 = *0x2::dynamic_field::borrow<AssetPairName, AssetPair>(0x2::kiosk::uid_mut_as_owner(arg0, &arg1.ownerCap), v0);
        assert!(0x1::type_name::get<T0>() == v1.nft && 0x1::type_name::get<T1>() == v1.token, 4002);
        let (v2, v3) = 0x2::kiosk::purchase<T0>(arg0, arg2, 0x2::coin::zero<0x2::sui::SUI>(arg3));
        let v4 = OrderID{id: arg2};
        let v5 = 0x2::dynamic_field::remove<OrderID, Order>(0x2::kiosk::uid_mut_as_owner(arg0, &arg1.ownerCap), v4);
        let v6 = OrderPurchased{
            nft_id      : arg2,
            kiosk       : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            vault       : 0x2::object::id<KioskVault>(arg1),
            nft_type    : v1.nft,
            token_type  : v1.token,
            price       : v5.price,
            match_price : v5.price,
            by          : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<OrderPurchased>(v6);
        (v2, v3, v5)
    }

    public fun createPublicKiosk<T0, T1>(arg0: &PKAdminCap, arg1: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::Kiosk, KioskVault) {
        let (v0, v1) = 0x2::kiosk::new(arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = AssetPair{
            nft   : 0x1::type_name::get<T0>(),
            token : 0x1::type_name::get<T1>(),
        };
        let v5 = AssetPairName{dummy_field: false};
        0x2::dynamic_field::add<AssetPairName, AssetPair>(0x2::kiosk::uid_mut_as_owner(&mut v3, &v2), v5, v4);
        let v6 = KioskVault{
            id       : 0x2::object::new(arg1),
            ownerCap : v2,
        };
        let v7 = PublicKioskCreated{
            by      : 0x2::tx_context::sender(arg1),
            nft     : v4.nft,
            token   : v4.token,
            id      : 0x2::object::id<0x2::kiosk::Kiosk>(&v3),
            vaultId : 0x2::object::id<KioskVault>(&v6),
        };
        0x2::event::emit<PublicKioskCreated>(v7);
        (v3, v6)
    }

    fun init(arg0: PUBLIC_KIOSK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PKAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<PKAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun orderInfo(arg0: &Order) : (0x2::object::ID, address, u64) {
        (arg0.id, arg0.owner, arg0.price)
    }

    public fun placeAndList<T0: store + key, T1>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut KioskVault, arg2: T0, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        place<T0, T1>(arg0, arg1, arg2, arg4);
        list<T0, T1>(arg0, arg1, 0x2::object::id<T0>(&arg2), arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

