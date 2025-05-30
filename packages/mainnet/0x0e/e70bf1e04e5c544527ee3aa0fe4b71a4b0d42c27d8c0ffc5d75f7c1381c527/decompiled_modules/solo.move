module 0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::solo {
    struct NFTListed has copy, drop {
        id: 0x2::object::ID,
        price: u64,
        owner: address,
        kiosk_id: 0x2::object::ID,
    }

    struct NFTDelisted has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        kiosk_id: 0x2::object::ID,
    }

    struct NFTPurchased has copy, drop {
        id: 0x2::object::ID,
        price: u64,
        seller: address,
        buyer: address,
        kiosk_id: 0x2::object::ID,
    }

    struct Store has key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct SwapOffer has store, key {
        id: 0x2::object::UID,
        offerer: address,
        receiver: address,
        offerer_kiosk_id: 0x2::object::ID,
        offerer_nft_id: 0x2::object::ID,
        receiver_kiosk_id: 0x2::object::ID,
        receiver_nft_id: 0x2::object::ID,
        status: u8,
    }

    struct SwapOfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        offerer_kiosk_id: 0x2::object::ID,
        offerer_nft_id: 0x2::object::ID,
        receiver_kiosk_id: 0x2::object::ID,
        receiver_nft_id: 0x2::object::ID,
        offerer: address,
        receiver: address,
    }

    struct SwapOfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        offerer_kiosk_id: 0x2::object::ID,
        offerer_nft_id: 0x2::object::ID,
        receiver_kiosk_id: 0x2::object::ID,
        receiver_nft_id: 0x2::object::ID,
        offerer: address,
        receiver: address,
    }

    struct SwapOfferAccepted has copy, drop {
        offer_id: 0x2::object::ID,
        offerer_kiosk_id: 0x2::object::ID,
        offerer_nft_id: 0x2::object::ID,
        receiver_kiosk_id: 0x2::object::ID,
        receiver_nft_id: 0x2::object::ID,
        offerer: address,
        receiver: address,
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

    public entry fun accept_swap_offer<T0: store + key, T1: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::PersonalKioskCap, arg6: &0x2::transfer_policy::TransferPolicy<T1>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 11);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, SwapOffer>(&mut arg0.id, arg1);
        assert!(v0.receiver == 0x2::tx_context::sender(arg7), 8);
        assert!(v0.status == 0, 13);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg2) == v0.offerer_kiosk_id, 3);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg4) == v0.receiver_kiosk_id, 3);
        assert!(0x2::kiosk::has_item(arg2, v0.offerer_nft_id), 2);
        assert!(0x2::kiosk::has_item(arg4, v0.receiver_nft_id), 2);
        assert!(!0x2::kiosk::is_listed(arg2, v0.offerer_nft_id), 6);
        assert!(!0x2::kiosk::is_listed(arg4, v0.receiver_nft_id), 6);
        v0.status = 1;
        let (v1, v2) = 0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::borrow_val(arg5);
        let v3 = v1;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T1>(arg6, 0x2::transfer_policy::new_request<T1>(v0.receiver_nft_id, 0, 0x2::object::id<0x2::kiosk::Kiosk>(arg4)));
        let (v7, v8) = 0x2::kiosk::purchase_with_cap<T0>(arg2, 0x2::kiosk::list_with_purchase_cap<T0>(arg2, &v3, v0.offerer_nft_id, 0, arg7), 0x2::coin::zero<0x2::sui::SUI>(arg7));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v8);
        0x2::kiosk::place<T0>(arg4, &v3, v7);
        0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::return_val(arg5, v3, v2);
        0x2::transfer::public_transfer<T1>(0x2::kiosk::take<T1>(arg4, &v3, v0.receiver_nft_id), v0.offerer);
        let v12 = SwapOfferAccepted{
            offer_id          : arg1,
            offerer_kiosk_id  : v0.offerer_kiosk_id,
            offerer_nft_id    : v0.offerer_nft_id,
            receiver_kiosk_id : v0.receiver_kiosk_id,
            receiver_nft_id   : v0.receiver_nft_id,
            offerer           : v0.offerer,
            receiver          : v0.receiver,
        };
        0x2::event::emit<SwapOfferAccepted>(v12);
    }

    public entry fun batch_delist_nfts<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::PersonalKioskCap, arg3: vector<0x2::object::ID>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::is_personal(arg1), 10);
        assert!(0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::owner(arg1) == 0x2::tx_context::sender(arg4), 1);
        let (v0, v1) = 0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::borrow_val(arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&arg3)) {
            let v3 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v2);
            assert!(0x2::kiosk::has_item(arg1, v3), 2);
            assert!(0x2::kiosk::is_listed(arg1, v3), 5);
            assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, v3), 9);
            let Listing {
                id          : v4,
                seller      : v5,
                kiosk_id    : _,
                nft_id      : _,
                cap         : v8,
                price       : _,
                commission  : _,
                beneficiary : _,
            } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg0.id, v3);
            assert!(v5 == 0x2::tx_context::sender(arg4), 8);
            0x2::kiosk::return_purchase_cap<T0>(arg1, v8);
            0x2::object::delete(v4);
            let v12 = NFTDelisted{
                id       : v3,
                owner    : 0x2::tx_context::sender(arg4),
                kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            };
            0x2::event::emit<NFTDelisted>(v12);
            v2 = v2 + 1;
        };
        0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::return_val(arg2, v0, v1);
    }

    public entry fun batch_list_nfts<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::PersonalKioskCap, arg3: vector<0x2::object::ID>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::is_personal(arg1), 10);
        assert!(0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::owner(arg1) == 0x2::tx_context::sender(arg5), 1);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg3);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 7);
        let (v1, v2) = 0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::borrow_val(arg2);
        let v3 = v1;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = *0x1::vector::borrow<0x2::object::ID>(&arg3, v4);
            let v6 = *0x1::vector::borrow<u64>(&arg4, v4);
            assert!(0x2::kiosk::has_item(arg1, v5), 2);
            assert!(!0x2::kiosk::is_listed(arg1, v5), 6);
            assert!(v6 > 0, 7);
            let v7 = Listing<T0>{
                id          : 0x2::object::new(arg5),
                seller      : 0x2::tx_context::sender(arg5),
                kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
                nft_id      : v5,
                cap         : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, &v3, v5, v6, arg5),
                price       : v6,
                commission  : 0,
                beneficiary : 0x2::tx_context::sender(arg5),
            };
            0x2::dynamic_object_field::add<0x2::object::ID, Listing<T0>>(&mut arg0.id, v5, v7);
            let v8 = NFTListed{
                id       : v5,
                price    : v6,
                owner    : 0x2::tx_context::sender(arg5),
                kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            };
            0x2::event::emit<NFTListed>(v8);
            v4 = v4 + 1;
        };
        0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::return_val(arg2, v3, v2);
    }

    public entry fun buy_and_place_in_kiosk<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &mut 0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::PersonalKioskCap, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::is_personal(arg1), 10);
        assert!(0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::is_personal(arg5), 10);
        assert!(0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::owner(arg5) == 0x2::tx_context::sender(arg7), 1);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg2), 9);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Listing<T0>>(&arg0.id, arg2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v0.kiosk_id, 3);
        assert!(0x2::kiosk::has_item(arg1, arg2), 2);
        assert!(0x2::kiosk::is_listed(arg1, arg2), 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= v0.price, 4);
        let v1 = 0x2::coin::split<0x2::sui::SUI>(arg3, v0.price, arg7);
        let Listing {
            id          : v2,
            seller      : v3,
            kiosk_id    : _,
            nft_id      : _,
            cap         : v6,
            price       : v7,
            commission  : _,
            beneficiary : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg2);
        let (v10, v11) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v6, v1);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v11);
        let (v15, v16) = 0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::borrow_val(arg6);
        let v17 = v15;
        0x2::kiosk::place<T0>(arg5, &v17, v10);
        0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::return_val(arg6, v17, v16);
        0x2::object::delete(v2);
        let v18 = NFTPurchased{
            id       : arg2,
            price    : v7,
            seller   : v3,
            buyer    : 0x2::tx_context::sender(arg7),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
        };
        0x2::event::emit<NFTPurchased>(v18);
    }

    public entry fun buy_nft<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::is_personal(arg1), 10);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg2), 9);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Listing<T0>>(&arg0.id, arg2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v0.kiosk_id, 3);
        assert!(0x2::kiosk::has_item(arg1, arg2), 2);
        assert!(0x2::kiosk::is_listed(arg1, arg2), 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg3) >= v0.price, 4);
        let v1 = 0x2::coin::split<0x2::sui::SUI>(arg3, v0.price, arg5);
        let Listing {
            id          : v2,
            seller      : v3,
            kiosk_id    : _,
            nft_id      : _,
            cap         : v6,
            price       : v7,
            commission  : _,
            beneficiary : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg2);
        let (v10, v11) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v6, v1);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v11);
        0x2::transfer::public_transfer<T0>(v10, 0x2::tx_context::sender(arg5));
        0x2::object::delete(v2);
        let v15 = NFTPurchased{
            id       : arg2,
            price    : v7,
            seller   : v3,
            buyer    : 0x2::tx_context::sender(arg5),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
        };
        0x2::event::emit<NFTPurchased>(v15);
    }

    public entry fun cancel_swap_offer(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 11);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, SwapOffer>(&mut arg0.id, arg1);
        assert!(v0.offerer == 0x2::tx_context::sender(arg2), 8);
        assert!(v0.status == 0, 13);
        v0.status = 2;
        let v1 = SwapOfferCancelled{
            offer_id          : arg1,
            offerer_kiosk_id  : v0.offerer_kiosk_id,
            offerer_nft_id    : v0.offerer_nft_id,
            receiver_kiosk_id : v0.receiver_kiosk_id,
            receiver_nft_id   : v0.receiver_nft_id,
            offerer           : v0.offerer,
            receiver          : v0.receiver,
        };
        0x2::event::emit<SwapOfferCancelled>(v1);
    }

    public entry fun create_store(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Store>(v0);
    }

    public entry fun create_swap_offer(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::PersonalKioskCap, arg3: 0x2::object::ID, arg4: &0x2::kiosk::Kiosk, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::is_personal(arg1), 10);
        assert!(0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::is_personal(arg4), 10);
        assert!(0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::owner(arg1) == 0x2::tx_context::sender(arg6), 1);
        assert!(0x2::kiosk::has_item(arg1, arg3), 2);
        assert!(0x2::kiosk::has_item(arg4, arg5), 2);
        assert!(!0x2::kiosk::is_listed(arg1, arg3), 6);
        let v0 = SwapOffer{
            id                : 0x2::object::new(arg6),
            offerer           : 0x2::tx_context::sender(arg6),
            receiver          : 0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::owner(arg4),
            offerer_kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            offerer_nft_id    : arg3,
            receiver_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            receiver_nft_id   : arg5,
            status            : 0,
        };
        let v1 = 0x2::object::id<SwapOffer>(&v0);
        0x2::dynamic_object_field::add<0x2::object::ID, SwapOffer>(&mut arg0.id, v1, v0);
        let v2 = SwapOfferCreated{
            offer_id          : v1,
            offerer_kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            offerer_nft_id    : arg3,
            receiver_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            receiver_nft_id   : arg5,
            offerer           : 0x2::tx_context::sender(arg6),
            receiver          : 0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::owner(arg4),
        };
        0x2::event::emit<SwapOfferCreated>(v2);
    }

    public entry fun delist_nft<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::PersonalKioskCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::is_personal(arg1), 10);
        assert!(0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::owner(arg1) == 0x2::tx_context::sender(arg4), 1);
        assert!(0x2::kiosk::has_item(arg1, arg3), 2);
        assert!(0x2::kiosk::is_listed(arg1, arg3), 5);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg3), 9);
        let Listing {
            id          : v0,
            seller      : v1,
            kiosk_id    : _,
            nft_id      : _,
            cap         : v4,
            price       : _,
            commission  : _,
            beneficiary : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg3);
        assert!(v1 == 0x2::tx_context::sender(arg4), 8);
        let (v8, v9) = 0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::borrow_val(arg2);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v4);
        0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::return_val(arg2, v8, v9);
        0x2::object::delete(v0);
        let v10 = NFTDelisted{
            id       : arg3,
            owner    : 0x2::tx_context::sender(arg4),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
        };
        0x2::event::emit<NFTDelisted>(v10);
    }

    public entry fun list_nft<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::PersonalKioskCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::is_personal(arg1), 10);
        assert!(0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::owner(arg1) == 0x2::tx_context::sender(arg5), 1);
        assert!(0x2::kiosk::has_item(arg1, arg3), 2);
        assert!(!0x2::kiosk::is_listed(arg1, arg3), 6);
        assert!(arg4 > 0, 7);
        let (v0, v1) = 0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::borrow_val(arg2);
        let v2 = v0;
        0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::return_val(arg2, v2, v1);
        let v3 = Listing<T0>{
            id          : 0x2::object::new(arg5),
            seller      : 0x2::tx_context::sender(arg5),
            kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id      : arg3,
            cap         : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, &v2, arg3, arg4, arg5),
            price       : arg4,
            commission  : 0,
            beneficiary : 0x2::tx_context::sender(arg5),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg3, v3);
        let v4 = NFTListed{
            id       : arg3,
            price    : arg4,
            owner    : 0x2::tx_context::sender(arg5),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
        };
        0x2::event::emit<NFTListed>(v4);
    }

    public entry fun update_listing_price<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::PersonalKioskCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::is_personal(arg1), 10);
        assert!(0xee70bf1e04e5c544527ee3aa0fe4b71a4b0d42c27d8c0ffc5d75f7c1381c527::personal_kiosk::owner(arg1) == 0x2::tx_context::sender(arg5), 1);
        assert!(0x2::kiosk::has_item(arg1, arg3), 2);
        assert!(0x2::kiosk::is_listed(arg1, arg3), 5);
        assert!(arg4 > 0, 7);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg3), 9);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg3);
        assert!(v0.seller == 0x2::tx_context::sender(arg5), 8);
        v0.price = arg4;
        let v1 = NFTListed{
            id       : arg3,
            price    : arg4,
            owner    : 0x2::tx_context::sender(arg5),
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
        };
        0x2::event::emit<NFTListed>(v1);
    }

    // decompiled from Move bytecode v6
}

