module 0xec175e537be9e48f75fa6929291de6454d2502f1091feb22c0d26a22821bbf28::kiosk_biddings {
    struct Store has key {
        id: 0x2::object::UID,
        escrow_kiosk_cap: 0x2::kiosk::KioskOwnerCap,
    }

    struct Escrow has store, key {
        id: 0x2::object::UID,
        buyer: address,
    }

    struct Bid has store, key {
        id: 0x2::object::UID,
        nft_type: 0x1::ascii::String,
        nft_id: 0x1::option::Option<0x2::object::ID>,
        buyer: address,
        price: u64,
        wallet: 0x2::coin::Coin<0x2::sui::SUI>,
        commission: u64,
        beneficiary: address,
    }

    struct CreateBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        buyer: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct CreateCollectionBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        token_amount: u64,
        buyer: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct CancelBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        buyer: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct CancelCollectionBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        buyer: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct MatchBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct MatchCollectionBidEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct ClaimEvent has copy, drop {
        nft_id: 0x2::object::ID,
    }

    public fun accept_bid<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Bid>(&mut arg0.id, arg1);
        let v1 = 0x1::type_name::get<T0>();
        assert!(*0x1::type_name::borrow_string(&v1) == v0.nft_type, 1);
        let v2 = v0.nft_id;
        if (0x1::option::is_some<0x2::object::ID>(&v2)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&v2) == arg5, 1);
        };
        let Bid {
            id          : v3,
            nft_type    : v4,
            nft_id      : _,
            buyer       : v6,
            price       : v7,
            wallet      : v8,
            commission  : v9,
            beneficiary : v10,
        } = v0;
        let v11 = v8;
        0x2::object::delete(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v11, v9, arg7), v10);
        let (v12, v13) = 0x2::kiosk::purchase_with_cap<T0>(arg3, 0x2::kiosk::list_with_purchase_cap<T0>(arg3, arg4, arg5, v7, arg7), 0x2::coin::split<0x2::sui::SUI>(&mut v11, v7, arg7));
        0x2::kiosk::lock<T0>(arg2, &arg0.escrow_kiosk_cap, arg6, v12);
        let v14 = Escrow{
            id    : 0x2::object::new(arg7),
            buyer : v6,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Escrow>(&mut arg0.id, arg5, v14);
        let v15 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::kiosk::withdraw(arg3, arg4, 0x1::option::none<u64>(), arg7), v15);
        if (0x1::option::is_some<0x2::object::ID>(&v2)) {
            let v16 = MatchBidEvent{
                bid_id      : arg1,
                nft_type    : v4,
                nft_id      : arg5,
                seller      : v15,
                buyer       : v6,
                price       : v7,
                commission  : v9,
                beneficiary : v10,
            };
            0x2::event::emit<MatchBidEvent>(v16);
        } else {
            let v17 = MatchCollectionBidEvent{
                bid_id      : arg1,
                nft_type    : v4,
                nft_id      : arg5,
                seller      : v15,
                buyer       : v6,
                price       : v7,
                commission  : v9,
                beneficiary : v10,
            };
            0x2::event::emit<MatchCollectionBidEvent>(v17);
        };
        (v11, v13)
    }

    public fun bid<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        bid_<T0>(arg0, 0x1::option::some<0x2::object::ID>(arg1), arg2, arg3, arg4, arg5, arg6);
    }

    fun bid_<T0: store + key>(arg0: &mut Store, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= arg2 + arg4, 1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = *0x1::type_name::borrow_string(&v0);
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = Bid{
            id          : 0x2::object::new(arg6),
            nft_type    : v1,
            nft_id      : arg1,
            buyer       : v2,
            price       : arg2,
            wallet      : 0x2::coin::split<0x2::sui::SUI>(arg3, arg2 + arg4, arg6),
            commission  : arg4,
            beneficiary : arg5,
        };
        let v4 = 0x2::object::id<Bid>(&v3);
        0x2::dynamic_object_field::add<0x2::object::ID, Bid>(&mut arg0.id, v4, v3);
        if (0x1::option::is_some<0x2::object::ID>(&arg1)) {
            let v5 = CreateBidEvent{
                bid_id      : v4,
                nft_type    : v1,
                nft_id      : *0x1::option::borrow<0x2::object::ID>(&arg1),
                buyer       : v2,
                price       : arg2,
                commission  : arg4,
                beneficiary : arg5,
            };
            0x2::event::emit<CreateBidEvent>(v5);
        } else {
            let v6 = CreateCollectionBidEvent{
                bid_id       : v4,
                nft_type     : v1,
                token_amount : 1,
                buyer        : v2,
                price        : arg2,
                commission   : arg4,
                beneficiary  : arg5,
            };
            0x2::event::emit<CreateCollectionBidEvent>(v6);
        };
    }

    public fun cancel_bid<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Bid>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg2) == v0.buyer, 0);
        let Bid {
            id          : v1,
            nft_type    : v2,
            nft_id      : v3,
            buyer       : v4,
            price       : v5,
            wallet      : v6,
            commission  : v7,
            beneficiary : v8,
        } = v0;
        let v9 = v3;
        0x2::object::delete(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, v4);
        if (0x1::option::is_some<0x2::object::ID>(&v9)) {
            let v10 = CancelBidEvent{
                bid_id      : arg1,
                nft_type    : v2,
                nft_id      : *0x1::option::borrow<0x2::object::ID>(&v9),
                buyer       : v4,
                price       : v5,
                commission  : v7,
                beneficiary : v8,
            };
            0x2::event::emit<CancelBidEvent>(v10);
        } else {
            let v11 = CancelCollectionBidEvent{
                bid_id      : arg1,
                nft_type    : v2,
                buyer       : v4,
                price       : v5,
                commission  : v7,
                beneficiary : v8,
            };
            0x2::event::emit<CancelCollectionBidEvent>(v11);
        };
    }

    public fun claim_bid<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Escrow>(&mut arg0.id, arg4);
        assert!(0x2::tx_context::sender(arg6) == v0.buyer, 0);
        let Escrow {
            id    : v1,
            buyer : _,
        } = v0;
        0x2::object::delete(v1);
        let (v3, v4) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, &arg0.escrow_kiosk_cap, arg4, 0, arg6), 0x2::coin::zero<0x2::sui::SUI>(arg6));
        0x2::kiosk::lock<T0>(arg2, arg3, arg5, v3);
        let v5 = ClaimEvent{nft_id: arg4};
        0x2::event::emit<ClaimEvent>(v5);
        v4
    }

    public fun collection_bid<T0: store + key>(arg0: &mut Store, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        bid_<T0>(arg0, 0x1::option::none<0x2::object::ID>(), arg1, arg2, arg3, arg4, arg5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        let v2 = Store{
            id               : 0x2::object::new(arg0),
            escrow_kiosk_cap : v1,
        };
        0x2::transfer::share_object<Store>(v2);
    }

    // decompiled from Move bytecode v6
}

