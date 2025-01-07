module 0xeaffb37b5abd7e0b61dd5f01e8f3e4298afe3936408f1763b658750ed7f7f18a::kiosk_listings {
    struct Store has key {
        id: 0x2::object::UID,
    }

    struct Listing<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
        price: u64,
        commission: 0x2::coin::Coin<0x2::sui::SUI>,
        beneficiary: address,
    }

    struct ListEvent has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct UnlistEvent has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

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
    }

    public fun buy<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg5) == v0.price, 1);
        let Listing {
            id          : v1,
            seller      : v2,
            kiosk_id    : _,
            nft_id      : _,
            cap         : v5,
            price       : v6,
            commission  : v7,
            beneficiary : v8,
        } = v0;
        let v9 = v7;
        0x2::object::delete(v1);
        let (v10, v11) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v5, 0x2::coin::split<0x2::sui::SUI>(arg5, v6, arg6));
        0x2::kiosk::place<T0>(arg2, arg3, v10);
        let v12 = BuyEvent{
            listing_id      : 0x2::object::uid_to_inner(&v0.id),
            seller          : v2,
            seller_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            buyer           : 0x2::tx_context::sender(arg6),
            buyer_kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            nft_id          : arg4,
            price           : v6,
            commission      : 0x2::coin::value<0x2::sui::SUI>(&v9),
            beneficiary     : v8,
        };
        0x2::event::emit<BuyEvent>(v12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, v8);
        v11
    }

    public fun buy_v2<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg5) == v0.price, 1);
        let Listing {
            id          : v1,
            seller      : v2,
            kiosk_id    : _,
            nft_id      : _,
            cap         : v5,
            price       : v6,
            commission  : v7,
            beneficiary : v8,
        } = v0;
        let v9 = v7;
        0x2::object::delete(v1);
        let (v10, v11) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v5, 0x2::coin::split<0x2::sui::SUI>(arg5, v6, arg6));
        let v12 = BuyEvent{
            listing_id      : 0x2::object::uid_to_inner(&v0.id),
            seller          : v2,
            seller_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            buyer           : 0x2::tx_context::sender(arg6),
            buyer_kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            nft_id          : arg4,
            price           : v6,
            commission      : 0x2::coin::value<0x2::sui::SUI>(&v9),
            beneficiary     : v8,
        };
        0x2::event::emit<BuyEvent>(v12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, v8);
        (v10, v11)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Store>(v0);
    }

    public fun list<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg5);
        assert!(v0 < arg4, 1);
        let v1 = 0x2::tx_context::sender(arg7);
        let v2 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v3 = Listing<T0>{
            id          : 0x2::object::new(arg7),
            seller      : v1,
            kiosk_id    : v2,
            nft_id      : arg3,
            cap         : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, arg4, arg7),
            price       : arg4,
            commission  : 0x2::coin::split<0x2::sui::SUI>(arg5, v0, arg7),
            beneficiary : arg6,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg3, v3);
        let v4 = ListEvent{
            listing_id  : 0x2::object::id<Listing<T0>>(&v3),
            seller      : v1,
            kiosk_id    : v2,
            nft_id      : arg3,
            price       : arg4,
            commission  : v0,
            beneficiary : arg6,
        };
        0x2::event::emit<ListEvent>(v4);
    }

    public fun unlist<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg1, arg2), 0);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg3);
        let Listing {
            id          : v1,
            seller      : v2,
            kiosk_id    : v3,
            nft_id      : _,
            cap         : v5,
            price       : v6,
            commission  : v7,
            beneficiary : v8,
        } = v0;
        let v9 = v7;
        0x2::object::delete(v1);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v5);
        let v10 = UnlistEvent{
            listing_id  : 0x2::object::uid_to_inner(&v0.id),
            seller      : v2,
            kiosk_id    : v3,
            nft_id      : arg3,
            price       : v6,
            commission  : 0x2::coin::value<0x2::sui::SUI>(&v9),
            beneficiary : v8,
        };
        0x2::event::emit<UnlistEvent>(v10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, v2);
    }

    // decompiled from Move bytecode v6
}

