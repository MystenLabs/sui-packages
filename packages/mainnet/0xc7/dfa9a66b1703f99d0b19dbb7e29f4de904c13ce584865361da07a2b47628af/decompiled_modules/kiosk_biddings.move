module 0xec175e537be9e48f75fa6929291de6454d2502f1091feb22c0d26a22821bbf28::kiosk_biddings {
    struct Store has key {
        id: 0x2::object::UID,
        escrow_kiosk_cap: 0x2::kiosk::KioskOwnerCap,
    }

    struct KumoKey has copy, drop, store {
        bid_id: 0x2::object::ID,
    }

    struct KumoAttributes has drop, store {
        accessory: 0x1::option::Option<0x1::ascii::String>,
        background: 0x1::option::Option<0x1::ascii::String>,
        eyes: 0x1::option::Option<0x1::ascii::String>,
        fur_colour: 0x1::option::Option<0x1::ascii::String>,
        mouth: 0x1::option::Option<0x1::ascii::String>,
        tail: 0x1::option::Option<0x1::ascii::String>,
        one_of_one: 0x1::option::Option<0x1::ascii::String>,
    }

    struct Escrow has store, key {
        id: 0x2::object::UID,
        buyer: address,
    }

    struct EscrowWithPurchaseCap<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        buyer: address,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
    }

    struct BidKey has copy, drop, store {
        bid_id: 0x2::object::ID,
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

    struct MatchBidWithPurchaseCapEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
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

    struct MatchCollectionBidWithPurchaseCapEvent has copy, drop {
        bid_id: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
        seller: address,
        seller_kiosk_id: 0x2::object::ID,
        buyer: address,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct ClaimEvent has copy, drop {
        nft_id: 0x2::object::ID,
    }

    struct ClaimWithPurchaseCapEvent has copy, drop {
        nft_id: 0x2::object::ID,
        buyer: address,
        buyer_kiosk_id: 0x2::object::ID,
    }

    public fun accept_bid<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bid>(&arg0.id, arg1)) {
            0x2::dynamic_object_field::remove<0x2::object::ID, Bid>(&mut arg0.id, arg1)
        } else {
            let v1 = BidKey{bid_id: arg1};
            0x2::dynamic_object_field::remove<BidKey, Bid>(&mut arg0.id, v1)
        };
        let v2 = v0;
        let v3 = 0x1::type_name::get<T0>();
        assert!(*0x1::type_name::borrow_string(&v3) == v2.nft_type, 1);
        let v4 = v2.nft_id;
        if (0x1::option::is_some<0x2::object::ID>(&v4)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&v4) == arg5, 1);
        };
        let Bid {
            id          : v5,
            nft_type    : v6,
            nft_id      : _,
            buyer       : v8,
            price       : v9,
            wallet      : v10,
            commission  : v11,
            beneficiary : v12,
        } = v2;
        let v13 = v10;
        0x2::object::delete(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v11, arg7), v12);
        let (v14, v15) = 0x2::kiosk::purchase_with_cap<T0>(arg3, 0x2::kiosk::list_with_purchase_cap<T0>(arg3, arg4, arg5, v9, arg7), 0x2::coin::split<0x2::sui::SUI>(&mut v13, v9, arg7));
        0x2::kiosk::lock<T0>(arg2, &arg0.escrow_kiosk_cap, arg6, v14);
        let v16 = Escrow{
            id    : 0x2::object::new(arg7),
            buyer : v8,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Escrow>(&mut arg0.id, arg5, v16);
        let v17 = 0x2::tx_context::sender(arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::kiosk::withdraw(arg3, arg4, 0x1::option::none<u64>(), arg7), v17);
        if (0x1::option::is_some<0x2::object::ID>(&v4)) {
            let v18 = MatchBidEvent{
                bid_id      : arg1,
                nft_type    : v6,
                nft_id      : arg5,
                seller      : v17,
                buyer       : v8,
                price       : v9,
                commission  : v11,
                beneficiary : v12,
            };
            0x2::event::emit<MatchBidEvent>(v18);
        } else {
            let v19 = MatchCollectionBidEvent{
                bid_id      : arg1,
                nft_type    : v6,
                nft_id      : arg5,
                seller      : v17,
                buyer       : v8,
                price       : v9,
                commission  : v11,
                beneficiary : v12,
            };
            0x2::event::emit<MatchCollectionBidEvent>(v19);
        };
        (v13, v15)
    }

    public fun accept_bid_with_price_lock<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bid>(&arg0.id, arg1)) {
            0x2::dynamic_object_field::remove<0x2::object::ID, Bid>(&mut arg0.id, arg1)
        } else {
            let v1 = BidKey{bid_id: arg1};
            0x2::dynamic_object_field::remove<BidKey, Bid>(&mut arg0.id, v1)
        };
        let v2 = v0;
        let v3 = 0x1::type_name::get<T0>();
        assert!(*0x1::type_name::borrow_string(&v3) == v2.nft_type, 1);
        let v4 = v2.nft_id;
        if (0x1::option::is_some<0x2::object::ID>(&v4)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&v4) == arg4, 1);
        };
        let Bid {
            id          : v5,
            nft_type    : v6,
            nft_id      : _,
            buyer       : v8,
            price       : v9,
            wallet      : v10,
            commission  : v11,
            beneficiary : v12,
        } = v2;
        let v13 = v10;
        0x2::object::delete(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v13, v11, arg5), v12);
        let v14 = EscrowWithPurchaseCap<T0>{
            id           : 0x2::object::new(arg5),
            buyer        : v8,
            purchase_cap : 0x2::kiosk::list_with_purchase_cap<T0>(arg2, arg3, arg4, 0, arg5),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, EscrowWithPurchaseCap<T0>>(&mut arg0.id, arg4, v14);
        if (0x1::option::is_some<0x2::object::ID>(&v4)) {
            let v15 = MatchBidWithPurchaseCapEvent{
                bid_id          : arg1,
                nft_type        : v6,
                nft_id          : arg4,
                seller          : 0x2::tx_context::sender(arg5),
                seller_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
                buyer           : v8,
                price           : v9,
                commission      : v11,
                beneficiary     : v12,
            };
            0x2::event::emit<MatchBidWithPurchaseCapEvent>(v15);
        } else {
            let v16 = MatchCollectionBidWithPurchaseCapEvent{
                bid_id          : arg1,
                nft_type        : v6,
                nft_id          : arg4,
                seller          : 0x2::tx_context::sender(arg5),
                seller_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
                buyer           : v8,
                price           : v9,
                commission      : v11,
                beneficiary     : v12,
            };
            0x2::event::emit<MatchCollectionBidWithPurchaseCapEvent>(v16);
        };
        (v13, 0x2::transfer_policy::new_request<T0>(arg4, v9, 0x2::object::id<0x2::kiosk::Kiosk>(arg2)))
    }

    public fun accept_bid_with_purchase_cap<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bid>(&arg0.id, arg1)) {
            0x2::dynamic_object_field::remove<0x2::object::ID, Bid>(&mut arg0.id, arg1)
        } else {
            let v1 = BidKey{bid_id: arg1};
            0x2::dynamic_object_field::remove<BidKey, Bid>(&mut arg0.id, v1)
        };
        let v2 = v0;
        let v3 = 0x1::type_name::get<T0>();
        assert!(*0x1::type_name::borrow_string(&v3) == v2.nft_type, 1);
        let v4 = v2.nft_id;
        if (0x1::option::is_some<0x2::object::ID>(&v4)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&v4) == arg4, 1);
        };
        if (0x2::kiosk::has_item_with_type<0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::Kumo>(arg2, arg4)) {
            let v5 = KumoKey{bid_id: arg1};
            let v6 = 0x2::dynamic_field::remove_if_exists<KumoKey, KumoAttributes>(&mut arg0.id, v5);
            if (0x1::option::is_some<KumoAttributes>(&v6)) {
                let v7 = 0x1::option::borrow<KumoAttributes>(&v6);
                let (v8, v9) = 0x2::kiosk::borrow_val<0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::Kumo>(arg2, arg3, arg4);
                let v10 = v8;
                let v11 = if (kumo_compare_attribute_values(v7.accessory, 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::accessory(&v10))) {
                    if (kumo_compare_attribute_values(v7.background, 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::background(&v10))) {
                        if (kumo_compare_attribute_values(v7.eyes, 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::eyes(&v10))) {
                            if (kumo_compare_attribute_values(v7.fur_colour, 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::fur_colour(&v10))) {
                                if (kumo_compare_attribute_values(v7.mouth, 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::mouth(&v10))) {
                                    if (kumo_compare_attribute_values(v7.tail, 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::tail(&v10))) {
                                        kumo_compare_attribute_values(v7.one_of_one, 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::one_of_one(&v10))
                                    } else {
                                        false
                                    }
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                };
                assert!(v11, 2);
                0x2::kiosk::return_val<0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::Kumo>(arg2, v10, v9);
            };
        };
        let Bid {
            id          : v12,
            nft_type    : v13,
            nft_id      : _,
            buyer       : v15,
            price       : v16,
            wallet      : v17,
            commission  : v18,
            beneficiary : v19,
        } = v2;
        let v20 = v17;
        0x2::object::delete(v12);
        let v21 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v20, v18, arg5), v19);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v20, v16, arg5), v21);
        let v22 = EscrowWithPurchaseCap<T0>{
            id           : 0x2::object::new(arg5),
            buyer        : v15,
            purchase_cap : 0x2::kiosk::list_with_purchase_cap<T0>(arg2, arg3, arg4, 0, arg5),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, EscrowWithPurchaseCap<T0>>(&mut arg0.id, arg4, v22);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::kiosk::withdraw(arg2, arg3, 0x1::option::none<u64>(), arg5), v21);
        if (0x1::option::is_some<0x2::object::ID>(&v4)) {
            let v23 = MatchBidWithPurchaseCapEvent{
                bid_id          : arg1,
                nft_type        : v13,
                nft_id          : arg4,
                seller          : v21,
                seller_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
                buyer           : v15,
                price           : v16,
                commission      : v18,
                beneficiary     : v19,
            };
            0x2::event::emit<MatchBidWithPurchaseCapEvent>(v23);
        } else {
            let v24 = MatchCollectionBidWithPurchaseCapEvent{
                bid_id          : arg1,
                nft_type        : v13,
                nft_id          : arg4,
                seller          : v21,
                seller_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
                buyer           : v15,
                price           : v16,
                commission      : v18,
                beneficiary     : v19,
            };
            0x2::event::emit<MatchCollectionBidWithPurchaseCapEvent>(v24);
        };
        (v20, 0x2::transfer_policy::new_request<T0>(arg4, v16, 0x2::object::id<0x2::kiosk::Kiosk>(arg2)))
    }

    entry fun admin_cancel_bid<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x51a1d3e9d4c9627739934b4a7be9e0dfe6c9c4bf4f7ec2e517f11f41c43d63bb, 0);
        let v0 = if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bid>(&arg0.id, arg1)) {
            0x2::dynamic_object_field::remove<0x2::object::ID, Bid>(&mut arg0.id, arg1)
        } else {
            let v1 = BidKey{bid_id: arg1};
            0x2::dynamic_object_field::remove<BidKey, Bid>(&mut arg0.id, v1)
        };
        let v2 = KumoKey{bid_id: arg1};
        0x2::dynamic_field::remove_if_exists<KumoKey, KumoAttributes>(&mut arg0.id, v2);
        let Bid {
            id          : v3,
            nft_type    : v4,
            nft_id      : v5,
            buyer       : v6,
            price       : v7,
            wallet      : v8,
            commission  : v9,
            beneficiary : v10,
        } = v0;
        let v11 = v5;
        0x2::object::delete(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v8, v6);
        if (0x1::option::is_some<0x2::object::ID>(&v11)) {
            let v12 = CancelBidEvent{
                bid_id      : arg1,
                nft_type    : v4,
                nft_id      : *0x1::option::borrow<0x2::object::ID>(&v11),
                buyer       : v6,
                price       : v7,
                commission  : v9,
                beneficiary : v10,
            };
            0x2::event::emit<CancelBidEvent>(v12);
        } else {
            let v13 = CancelCollectionBidEvent{
                bid_id      : arg1,
                nft_type    : v4,
                buyer       : v6,
                price       : v7,
                commission  : v9,
                beneficiary : v10,
            };
            0x2::event::emit<CancelCollectionBidEvent>(v13);
        };
    }

    public fun admin_claim_bid_with_purchase_cap<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == @0x51a1d3e9d4c9627739934b4a7be9e0dfe6c9c4bf4f7ec2e517f11f41c43d63bb, 0);
        let EscrowWithPurchaseCap {
            id           : v0,
            buyer        : v1,
            purchase_cap : v2,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, EscrowWithPurchaseCap<T0>>(&mut arg0.id, arg2);
        0x2::object::delete(v0);
        let (v3, v4) = 0x2::kiosk::new(arg4);
        let v5 = v4;
        let v6 = v3;
        let (v7, v8) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v2, 0x2::coin::zero<0x2::sui::SUI>(arg4));
        let v9 = v8;
        let v10 = ClaimWithPurchaseCapEvent{
            nft_id         : arg2,
            buyer          : v1,
            buyer_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(&v6),
        };
        0x2::event::emit<ClaimWithPurchaseCapEvent>(v10);
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg3)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg3, &mut v9, 0x2::coin::zero<0x2::sui::SUI>(arg4));
        };
        0x2::kiosk::lock<T0>(&mut v6, &v5, arg3, v7);
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg3)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v9, &v6);
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::Rule>(arg3)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::create_for(&mut v6, v5, v1, arg4);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::prove<T0>(&v6, &mut v9);
        } else {
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v5, v1);
        };
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v6);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v9);
    }

    public fun bid<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        bid_<T0>(arg0, 0x1::option::some<0x2::object::ID>(arg1), arg2, arg3, arg4, arg5, arg6);
    }

    fun bid_<T0: store + key>(arg0: &mut Store, arg1: 0x1::option::Option<0x2::object::ID>, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg3) - arg2 + arg4;
        assert!(v0 >= 0, 1);
        let v1 = 0x1::type_name::get<T0>();
        let v2 = *0x1::type_name::borrow_string(&v1);
        let v3 = 0x2::tx_context::sender(arg6);
        let v4 = Bid{
            id          : 0x2::object::new(arg6),
            nft_type    : v2,
            nft_id      : arg1,
            buyer       : v3,
            price       : arg2,
            wallet      : 0x2::coin::split<0x2::sui::SUI>(arg3, arg2 + arg4 + v0, arg6),
            commission  : arg4,
            beneficiary : arg5,
        };
        let v5 = 0x2::object::id<Bid>(&v4);
        let v6 = BidKey{bid_id: v5};
        0x2::dynamic_object_field::add<BidKey, Bid>(&mut arg0.id, v6, v4);
        if (0x1::option::is_some<0x2::object::ID>(&arg1)) {
            let v7 = CreateBidEvent{
                bid_id      : v5,
                nft_type    : v2,
                nft_id      : *0x1::option::borrow<0x2::object::ID>(&arg1),
                buyer       : v3,
                price       : arg2,
                commission  : arg4,
                beneficiary : arg5,
            };
            0x2::event::emit<CreateBidEvent>(v7);
        } else {
            let v8 = CreateCollectionBidEvent{
                bid_id       : v5,
                nft_type     : v2,
                token_amount : 1,
                buyer        : v3,
                price        : arg2,
                commission   : arg4,
                beneficiary  : arg5,
            };
            0x2::event::emit<CreateCollectionBidEvent>(v8);
        };
        v5
    }

    public fun cancel_bid<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, Bid>(&arg0.id, arg1)) {
            0x2::dynamic_object_field::remove<0x2::object::ID, Bid>(&mut arg0.id, arg1)
        } else {
            let v1 = BidKey{bid_id: arg1};
            0x2::dynamic_object_field::remove<BidKey, Bid>(&mut arg0.id, v1)
        };
        let v2 = v0;
        let v3 = KumoKey{bid_id: arg1};
        0x2::dynamic_field::remove_if_exists<KumoKey, KumoAttributes>(&mut arg0.id, v3);
        assert!(0x2::tx_context::sender(arg2) == v2.buyer, 0);
        let Bid {
            id          : v4,
            nft_type    : v5,
            nft_id      : v6,
            buyer       : v7,
            price       : v8,
            wallet      : v9,
            commission  : v10,
            beneficiary : v11,
        } = v2;
        let v12 = v6;
        0x2::object::delete(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, v7);
        if (0x1::option::is_some<0x2::object::ID>(&v12)) {
            let v13 = CancelBidEvent{
                bid_id      : arg1,
                nft_type    : v5,
                nft_id      : *0x1::option::borrow<0x2::object::ID>(&v12),
                buyer       : v7,
                price       : v8,
                commission  : v10,
                beneficiary : v11,
            };
            0x2::event::emit<CancelBidEvent>(v13);
        } else {
            let v14 = CancelCollectionBidEvent{
                bid_id      : arg1,
                nft_type    : v5,
                buyer       : v7,
                price       : v8,
                commission  : v10,
                beneficiary : v11,
            };
            0x2::event::emit<CancelCollectionBidEvent>(v14);
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

    public fun claim_bid_with_purchase_cap<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, EscrowWithPurchaseCap<T0>>(&mut arg0.id, arg4);
        assert!(0x2::tx_context::sender(arg6) == v0.buyer, 0);
        let EscrowWithPurchaseCap {
            id           : v1,
            buyer        : v2,
            purchase_cap : v3,
        } = v0;
        0x2::object::delete(v1);
        let (v4, v5) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v3, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        0x2::kiosk::lock<T0>(arg2, arg3, arg5, v4);
        let v6 = ClaimWithPurchaseCapEvent{
            nft_id         : arg4,
            buyer          : v2,
            buyer_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
        };
        0x2::event::emit<ClaimWithPurchaseCapEvent>(v6);
        v5
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

    public fun kumo_bid<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: address, arg6: 0x1::option::Option<0x1::ascii::String>, arg7: 0x1::option::Option<0x1::ascii::String>, arg8: 0x1::option::Option<0x1::ascii::String>, arg9: 0x1::option::Option<0x1::ascii::String>, arg10: 0x1::option::Option<0x1::ascii::String>, arg11: 0x1::option::Option<0x1::ascii::String>, arg12: 0x1::option::Option<0x1::ascii::String>, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = bid_<T0>(arg0, 0x1::option::some<0x2::object::ID>(arg1), arg2, arg3, arg4, arg5, arg13);
        let v1 = KumoKey{bid_id: v0};
        let v2 = KumoAttributes{
            accessory  : arg6,
            background : arg7,
            eyes       : arg8,
            fur_colour : arg9,
            mouth      : arg10,
            tail       : arg11,
            one_of_one : arg12,
        };
        0x2::dynamic_field::add<KumoKey, KumoAttributes>(&mut arg0.id, v1, v2);
    }

    fun kumo_compare_attribute_values(arg0: 0x1::option::Option<0x1::ascii::String>, arg1: 0x1::string::String) : bool {
        let v0 = kumo_convert_attribute_value(arg1);
        if (0x1::option::is_none<0x1::ascii::String>(&arg0)) {
            return true
        };
        0x1::option::is_some<0x1::ascii::String>(&v0) && *0x1::option::borrow<0x1::ascii::String>(&arg0) == *0x1::option::borrow<0x1::ascii::String>(&v0)
    }

    fun kumo_convert_attribute_value(arg0: 0x1::string::String) : 0x1::option::Option<0x1::ascii::String> {
        let v0 = 0x1::string::to_ascii(arg0);
        let v1 = 0x1::ascii::to_lowercase(&v0);
        if (v1 == 0x1::ascii::string(b"default") || v1 == 0x1::ascii::string(b"none")) {
            0x1::option::none<0x1::ascii::String>()
        } else {
            0x1::option::some<0x1::ascii::String>(0x1::string::to_ascii(arg0))
        }
    }

    // decompiled from Move bytecode v6
}

