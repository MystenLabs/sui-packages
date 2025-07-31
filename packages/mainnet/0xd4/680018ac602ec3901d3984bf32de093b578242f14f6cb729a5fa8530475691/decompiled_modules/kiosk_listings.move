module 0xd4680018ac602ec3901d3984bf32de093b578242f14f6cb729a5fa8530475691::kiosk_listings {
    struct BuyEvent has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
        buyer: address,
        buyer_kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        price: u64,
        commission: u64,
        beneficiary: address,
        nft_type: 0x1::ascii::String,
    }

    struct ListEvent has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        price: u64,
        commission: u64,
        beneficiary: address,
        nft_type: 0x1::ascii::String,
    }

    struct Listing<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct Store has key {
        id: 0x2::object::UID,
    }

    struct UnlistEvent has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        price: u64,
        commission: u64,
        beneficiary: address,
        nft_type: 0x1::ascii::String,
    }

    public fun buy<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>, u64) {
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg4) == v0.price, 1);
        let Listing {
            id          : v1,
            seller      : v2,
            kiosk_id    : _,
            nft_id      : v4,
            cap         : v5,
            price       : v6,
            commission  : v7,
            beneficiary : v8,
        } = v0;
        0x2::object::delete(v1);
        let v9 = 0x1::type_name::get<T0>();
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg4, v7, arg5), v8);
        let v10 = v6 - v7;
        let (v11, v12) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v5, 0x2::coin::split<0x2::sui::SUI>(arg4, v10, arg5));
        let v13 = BuyEvent{
            listing_id      : 0x2::object::uid_to_inner(&v0.id),
            seller          : v2,
            seller_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            buyer           : 0x2::tx_context::sender(arg5),
            buyer_kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            nft_id          : v4,
            price           : v6,
            commission      : v7,
            beneficiary     : v8,
            nft_type        : *0x1::type_name::borrow_string(&v9),
        };
        0x2::event::emit<BuyEvent>(v13);
        (v11, v12, v10)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Store>(v0);
    }

    public fun list<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 < arg4, 1);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v3 = Listing<T0>{
            id          : 0x2::object::new(arg7),
            seller      : v1,
            kiosk_id    : v2,
            nft_id      : arg3,
            cap         : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, arg4 - arg5, arg7),
            price       : arg4,
            commission  : arg5,
            beneficiary : arg6,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg3, v3);
        let v4 = ListEvent{
            listing_id  : 0x2::object::id<Listing<T0>>(&v3),
            seller      : v1,
            kiosk_id    : v2,
            nft_id      : arg3,
            price       : arg4,
            commission  : arg5,
            beneficiary : arg6,
            nft_type    : *0x1::type_name::borrow_string(&v0),
        };
        0x2::event::emit<ListEvent>(v4);
    }

    public fun unlist<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg1, arg2), 0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg3);
        let Listing {
            id          : v2,
            seller      : v3,
            kiosk_id    : v4,
            nft_id      : _,
            cap         : v6,
            price       : v7,
            commission  : v8,
            beneficiary : v9,
        } = v1;
        0x2::object::delete(v2);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v6);
        let v10 = UnlistEvent{
            listing_id  : 0x2::object::uid_to_inner(&v1.id),
            seller      : v3,
            kiosk_id    : v4,
            nft_id      : arg3,
            price       : v7,
            commission  : v8,
            beneficiary : v9,
            nft_type    : *0x1::type_name::borrow_string(&v0),
        };
        0x2::event::emit<UnlistEvent>(v10);
    }

    // decompiled from Move bytecode v6
}

