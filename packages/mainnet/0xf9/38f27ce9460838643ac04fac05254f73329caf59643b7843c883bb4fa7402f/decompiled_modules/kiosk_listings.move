module 0xf938f27ce9460838643ac04fac05254f73329caf59643b7843c883bb4fa7402f::kiosk_listings {
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
        commission: u64,
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

    public fun buy<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg4);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg5) == v0.price + v0.commission, 1);
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
        0x2::object::delete(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg5, v7, arg6), v8);
        let (v9, v10) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v5, 0x2::coin::split<0x2::sui::SUI>(arg5, v6, arg6));
        let v11 = BuyEvent{
            listing_id      : 0x2::object::uid_to_inner(&v0.id),
            seller          : v2,
            seller_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            buyer           : 0x2::tx_context::sender(arg6),
            buyer_kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
            nft_id          : arg4,
            price           : v6,
            commission      : v7,
            beneficiary     : v8,
        };
        0x2::event::emit<BuyEvent>(v11);
        (v9, v10)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<Store>(v0);
    }

    public fun list<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 < arg4, 1);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        let v2 = Listing<T0>{
            id          : 0x2::object::new(arg7),
            seller      : v0,
            kiosk_id    : v1,
            nft_id      : arg3,
            cap         : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, arg4, arg7),
            price       : arg4,
            commission  : arg5,
            beneficiary : arg6,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg3, v2);
        let v3 = ListEvent{
            listing_id  : 0x2::object::id<Listing<T0>>(&v2),
            seller      : v0,
            kiosk_id    : v1,
            nft_id      : arg3,
            price       : arg4,
            commission  : arg5,
            beneficiary : arg6,
        };
        0x2::event::emit<ListEvent>(v3);
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
        0x2::object::delete(v1);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v5);
        let v9 = UnlistEvent{
            listing_id  : 0x2::object::uid_to_inner(&v0.id),
            seller      : v2,
            kiosk_id    : v3,
            nft_id      : arg3,
            price       : v6,
            commission  : v7,
            beneficiary : v8,
        };
        0x2::event::emit<UnlistEvent>(v9);
    }

    // decompiled from Move bytecode v6
}

