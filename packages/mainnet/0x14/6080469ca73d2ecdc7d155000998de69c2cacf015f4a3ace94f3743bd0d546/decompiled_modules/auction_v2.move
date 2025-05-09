module 0x146080469ca73d2ecdc7d155000998de69c2cacf015f4a3ace94f3743bd0d546::auction_v2 {
    struct Store has key {
        id: 0x2::object::UID,
        auction_kiosk_cap: 0x2::kiosk::KioskOwnerCap,
        orphaned_caps: 0x2::object::UID,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
    }

    struct SwapOffer<phantom T0: store + key, phantom T1: store + key> has store, key {
        id: 0x2::object::UID,
        offerer: address,
        offered_kiosk: 0x2::object::ID,
        offered_nft: 0x2::object::ID,
        requested_nft: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        status: u8,
        fee: u64,
    }

    struct AcceptOffer<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        receiver: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        original_nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
        status: u8,
    }

    struct DirectNftOffer<phantom T0: store + key, phantom T1: store + key> has store, key {
        id: 0x2::object::UID,
        offerer: address,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        status: u8,
        fee: u64,
    }

    struct NftEscrow<T0: store + key> has store, key {
        id: 0x2::object::UID,
        nft: T0,
    }

    struct OrphanedPurchaseCap<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
    }

    struct SwapOfferCreated has copy, drop {
        offerer: address,
        offered_kiosk: 0x2::object::ID,
        offered_nft: 0x2::object::ID,
        requested_nft: 0x2::object::ID,
        fee: u64,
    }

    struct DirectNftOfferCreated has copy, drop {
        offerer: address,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
        fee: u64,
    }

    struct SwapOfferCancelled has copy, drop {
        offerer: address,
        offered_nft: 0x2::object::ID,
        requested_nft: 0x2::object::ID,
    }

    struct DirectNftOfferCancelled has copy, drop {
        offerer: address,
        offered_nft_id: 0x2::object::ID,
        requested_nft_id: 0x2::object::ID,
    }

    struct ClaimOffer has copy, drop {
        receiver: address,
        receiver_kiosk_id: 0x2::object::ID,
        sender: address,
        sender_kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        fee_paid: u64,
    }

    struct DirectNftOfferAccepted has copy, drop {
        receiver: address,
        sender: address,
        offered_nft_id: 0x2::object::ID,
        received_nft_id: 0x2::object::ID,
        fee_paid: u64,
    }

    struct SwapCompleted has copy, drop {
        offerer: address,
        receiver: address,
        offered_nft: 0x2::object::ID,
        received_nft: 0x2::object::ID,
    }

    struct PurchaseCapOrphaned has copy, drop {
        nft_id: 0x2::object::ID,
        emergency_action: bool,
    }

    struct FeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    public fun accept_direct_offer<T0: store + key, T1: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: T1, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectNftOffer<T0, T1>>(&arg0.id, arg1), 6);
        let DirectNftOffer {
            id               : v0,
            offerer          : v1,
            offered_nft_id   : v2,
            requested_nft_id : v3,
            status           : v4,
            fee              : v5,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, DirectNftOffer<T0, T1>>(&mut arg0.id, arg1);
        let v6 = v0;
        assert!(v4 == 0, 2);
        assert!(0x2::object::id<T1>(&arg2) == v3, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v5, 9);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let NftEscrow {
            id  : v7,
            nft : v8,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftEscrow<T0>>(&mut arg0.id, 0x2::object::uid_to_inner(&v6));
        0x2::object::delete(v6);
        0x2::object::delete(v7);
        0x2::transfer::public_transfer<T1>(arg2, v1);
        let v9 = DirectNftOfferAccepted{
            receiver        : 0x2::tx_context::sender(arg4),
            sender          : v1,
            offered_nft_id  : v2,
            received_nft_id : v3,
            fee_paid        : v5,
        };
        0x2::event::emit<DirectNftOfferAccepted>(v9);
        v8
    }

    public fun accept_offer<T0: store + key, T1: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: 0x2::object::ID, arg8: &0x2::transfer_policy::TransferPolicy<T0>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg7), 6);
        let SwapOffer {
            id            : v0,
            offerer       : v1,
            offered_kiosk : v2,
            offered_nft   : v3,
            requested_nft : _,
            purchase_cap  : v5,
            status        : v6,
            fee           : v7,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, SwapOffer<T0, T1>>(&mut arg0.id, arg7);
        assert!(v3 == arg7, 4);
        assert!(v6 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg4) == v2, 3);
        assert!(0x2::kiosk::has_item(arg1, arg3), 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg9) >= v7, 9);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg9));
        0x2::object::delete(v0);
        0x2::tx_context::sender(arg10);
        let v8 = AcceptOffer<T1>{
            id              : 0x2::object::new(arg10),
            receiver        : v1,
            kiosk_id        : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id          : arg3,
            original_nft_id : arg7,
            purchase_cap    : 0x2::kiosk::list_with_purchase_cap<T1>(arg1, arg2, arg3, 0, arg10),
            status          : 0,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, AcceptOffer<T1>>(&mut arg0.id, arg3, v8);
        let (v9, v10) = 0x2::kiosk::purchase_with_cap<T0>(arg4, v5, 0x2::coin::zero<0x2::sui::SUI>(arg10));
        0x2::kiosk::lock<T0>(arg5, arg6, arg8, v9);
        let v11 = ClaimOffer{
            receiver          : 0x2::tx_context::sender(arg10),
            receiver_kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg5),
            sender            : v1,
            sender_kiosk_id   : 0x2::object::id<0x2::kiosk::Kiosk>(arg4),
            nft_id            : arg7,
            fee_paid          : v7,
        };
        0x2::event::emit<ClaimOffer>(v11);
        v10
    }

    public fun accept_offer_exists<T0: store + key>(arg0: &Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, AcceptOffer<T0>>(&arg0.id, arg1)
    }

    public fun cancel_direct_offer<T0: store + key, T1: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectNftOffer<T0, T1>>(&arg0.id, arg1), 6);
        let DirectNftOffer {
            id               : v0,
            offerer          : v1,
            offered_nft_id   : v2,
            requested_nft_id : v3,
            status           : v4,
            fee              : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, DirectNftOffer<T0, T1>>(&mut arg0.id, arg1);
        let v6 = v0;
        assert!(0x2::tx_context::sender(arg2) == v1, 1);
        assert!(v4 == 0, 2);
        let NftEscrow {
            id  : v7,
            nft : v8,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftEscrow<T0>>(&mut arg0.id, 0x2::object::uid_to_inner(&v6));
        0x2::object::delete(v6);
        0x2::object::delete(v7);
        let v9 = DirectNftOfferCancelled{
            offerer          : v1,
            offered_nft_id   : v2,
            requested_nft_id : v3,
        };
        0x2::event::emit<DirectNftOfferCancelled>(v9);
        v8
    }

    public fun cancel_offer<T0: store + key, T1: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg2), 6);
        let SwapOffer {
            id            : v0,
            offerer       : v1,
            offered_kiosk : v2,
            offered_nft   : _,
            requested_nft : v4,
            purchase_cap  : v5,
            status        : v6,
            fee           : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, SwapOffer<T0, T1>>(&mut arg0.id, arg2);
        assert!(0x2::tx_context::sender(arg3) == v1, 1);
        assert!(v6 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v2, 3);
        0x2::object::delete(v0);
        0x2::kiosk::return_purchase_cap<T0>(arg1, v5);
        let v8 = SwapOfferCancelled{
            offerer       : v1,
            offered_nft   : arg2,
            requested_nft : v4,
        };
        0x2::event::emit<SwapOfferCancelled>(v8);
    }

    public fun claim_swap_creator_nft<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, AcceptOffer<T0>>(&arg0.id, arg4), 6);
        let AcceptOffer {
            id              : v0,
            receiver        : v1,
            kiosk_id        : v2,
            nft_id          : v3,
            original_nft_id : v4,
            purchase_cap    : v5,
            status          : v6,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, AcceptOffer<T0>>(&mut arg0.id, arg4);
        assert!(0x2::tx_context::sender(arg6) == v1, 1);
        assert!(v6 == 0, 2);
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg1) == v2, 3);
        0x2::object::delete(v0);
        let (v7, v8) = 0x2::kiosk::purchase_with_cap<T0>(arg1, v5, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        0x2::kiosk::lock<T0>(arg2, arg3, arg5, v7);
        let v9 = SwapCompleted{
            offerer      : 0x2::tx_context::sender(arg6),
            receiver     : v1,
            offered_nft  : v3,
            received_nft : v4,
        };
        0x2::event::emit<SwapCompleted>(v9);
        v8
    }

    public fun create_direct_offer<T0: store + key, T1: store + key>(arg0: &mut Store, arg1: T0, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::id<T0>(&arg1);
        let v2 = 0x2::object::new(arg4);
        let v3 = DirectNftOffer<T0, T1>{
            id               : v2,
            offerer          : v0,
            offered_nft_id   : v1,
            requested_nft_id : arg2,
            status           : 0,
            fee              : arg3,
        };
        let v4 = NftEscrow<T0>{
            id  : 0x2::object::new(arg4),
            nft : arg1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, DirectNftOffer<T0, T1>>(&mut arg0.id, v1, v3);
        0x2::dynamic_object_field::add<0x2::object::ID, NftEscrow<T0>>(&mut arg0.id, 0x2::object::uid_to_inner(&v2), v4);
        let v5 = DirectNftOfferCreated{
            offerer          : v0,
            offered_nft_id   : v1,
            requested_nft_id : arg2,
            fee              : arg3,
        };
        0x2::event::emit<DirectNftOfferCreated>(v5);
    }

    public fun create_offer<T0: store + key, T1: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg1);
        assert!(0x2::kiosk::has_item(arg1, arg3), 5);
        let v2 = SwapOffer<T0, T1>{
            id            : 0x2::object::new(arg6),
            offerer       : v0,
            offered_kiosk : v1,
            offered_nft   : arg3,
            requested_nft : arg4,
            purchase_cap  : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, arg3, 0, arg6),
            status        : 0,
            fee           : arg5,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, SwapOffer<T0, T1>>(&mut arg0.id, arg3, v2);
        let v3 = SwapOfferCreated{
            offerer       : v0,
            offered_kiosk : v1,
            offered_nft   : arg3,
            requested_nft : arg4,
            fee           : arg5,
        };
        0x2::event::emit<SwapOfferCreated>(v3);
    }

    public entry fun create_personal_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg0), arg0);
    }

    public fun create_personal_kiosk_ptb(arg0: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        (0x2::object::id<0x2::kiosk::Kiosk>(&v2), 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v2, v1, arg0))
    }

    public fun direct_offer_exists<T0: store + key, T1: store + key>(arg0: &Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectNftOffer<T0, T1>>(&arg0.id, arg1)
    }

    public entry fun emergency_reset_accept_offer<T0: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x349c65d3fa8c667107fafe276f2260f54d0c97b6e403ce1686f3063a611e554d, 1);
        if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, AcceptOffer<T0>>(&arg0.id, arg1)) {
            let AcceptOffer {
                id              : v0,
                receiver        : _,
                kiosk_id        : _,
                nft_id          : _,
                original_nft_id : _,
                purchase_cap    : v5,
                status          : _,
            } = 0x2::dynamic_object_field::remove<0x2::object::ID, AcceptOffer<T0>>(&mut arg0.id, arg1);
            0x2::object::delete(v0);
            store_orphaned_cap<T0>(arg0, v5, arg1, true, arg2);
        };
    }

    public entry fun emergency_reset_direct_offer<T0: store + key, T1: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x349c65d3fa8c667107fafe276f2260f54d0c97b6e403ce1686f3063a611e554d, 1);
        if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectNftOffer<T0, T1>>(&arg0.id, arg1)) {
            let DirectNftOffer {
                id               : v0,
                offerer          : v1,
                offered_nft_id   : _,
                requested_nft_id : _,
                status           : _,
                fee              : _,
            } = 0x2::dynamic_object_field::remove<0x2::object::ID, DirectNftOffer<T0, T1>>(&mut arg0.id, arg1);
            let v6 = v0;
            let v7 = 0x2::object::uid_to_inner(&v6);
            if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, NftEscrow<T0>>(&arg0.id, v7)) {
                let NftEscrow {
                    id  : v8,
                    nft : v9,
                } = 0x2::dynamic_object_field::remove<0x2::object::ID, NftEscrow<T0>>(&mut arg0.id, v7);
                0x2::object::delete(v8);
                0x2::transfer::public_transfer<T0>(v9, v1);
            };
            0x2::object::delete(v6);
        };
    }

    public entry fun emergency_reset_offer<T0: store + key, T1: store + key>(arg0: &mut Store, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x349c65d3fa8c667107fafe276f2260f54d0c97b6e403ce1686f3063a611e554d, 1);
        if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg1)) {
            let SwapOffer {
                id            : v0,
                offerer       : _,
                offered_kiosk : _,
                offered_nft   : _,
                requested_nft : _,
                purchase_cap  : v5,
                status        : _,
                fee           : _,
            } = 0x2::dynamic_object_field::remove<0x2::object::ID, SwapOffer<T0, T1>>(&mut arg0.id, arg1);
            0x2::object::delete(v0);
            store_orphaned_cap<T0>(arg0, v5, arg1, true, arg2);
        };
    }

    public fun get_direct_offer_fee<T0: store + key, T1: store + key>(arg0: &Store, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectNftOffer<T0, T1>>(&arg0.id, arg1), 6);
        0x2::dynamic_object_field::borrow<0x2::object::ID, DirectNftOffer<T0, T1>>(&arg0.id, arg1).fee
    }

    public fun get_direct_offer_offerer<T0: store + key, T1: store + key>(arg0: &Store, arg1: 0x2::object::ID) : address {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectNftOffer<T0, T1>>(&arg0.id, arg1), 6);
        0x2::dynamic_object_field::borrow<0x2::object::ID, DirectNftOffer<T0, T1>>(&arg0.id, arg1).offerer
    }

    public fun get_direct_offer_requested_nft<T0: store + key, T1: store + key>(arg0: &Store, arg1: 0x2::object::ID) : 0x2::object::ID {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, DirectNftOffer<T0, T1>>(&arg0.id, arg1), 6);
        0x2::dynamic_object_field::borrow<0x2::object::ID, DirectNftOffer<T0, T1>>(&arg0.id, arg1).requested_nft_id
    }

    public fun get_offer_fee<T0: store + key, T1: store + key>(arg0: &Store, arg1: 0x2::object::ID) : u64 {
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg1), 6);
        0x2::dynamic_object_field::borrow<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg1).fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        let v2 = Store{
            id                : 0x2::object::new(arg0),
            auction_kiosk_cap : v1,
            orphaned_caps     : 0x2::object::new(arg0),
            fee_balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            owner             : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Store>(v2);
    }

    public fun offer_exists<T0: store + key, T1: store + key>(arg0: &Store, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists_with_type<0x2::object::ID, SwapOffer<T0, T1>>(&arg0.id, arg1)
    }

    public entry fun recover_orphaned_cap<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == @0x349c65d3fa8c667107fafe276f2260f54d0c97b6e403ce1686f3063a611e554d || 0x2::kiosk::owner(arg1) == v0, 1);
        assert!(0x2::kiosk::has_access(arg1, arg2), 1);
        if (0x2::dynamic_object_field::exists_with_type<0x2::object::ID, OrphanedPurchaseCap<T0>>(&arg0.orphaned_caps, arg3)) {
            let OrphanedPurchaseCap {
                id  : v1,
                cap : v2,
            } = 0x2::dynamic_object_field::remove<0x2::object::ID, OrphanedPurchaseCap<T0>>(&mut arg0.orphaned_caps, arg3);
            0x2::object::delete(v1);
            0x2::kiosk::return_purchase_cap<T0>(arg1, v2);
        };
    }

    fun store_orphaned_cap<T0: store + key>(arg0: &mut Store, arg1: 0x2::kiosk::PurchaseCap<T0>, arg2: 0x2::object::ID, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = OrphanedPurchaseCap<T0>{
            id  : 0x2::object::new(arg4),
            cap : arg1,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, OrphanedPurchaseCap<T0>>(&mut arg0.orphaned_caps, arg2, v0);
        let v1 = PurchaseCapOrphaned{
            nft_id           : arg2,
            emergency_action : arg3,
        };
        0x2::event::emit<PurchaseCapOrphaned>(v1);
    }

    public entry fun update_owner(arg0: &mut Store, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.owner = arg1;
    }

    public entry fun withdraw_fees(arg0: &mut Store, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fee_balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.fee_balance, v0), arg1), arg0.owner);
        let v1 = FeesWithdrawn{
            amount    : v0,
            recipient : arg0.owner,
        };
        0x2::event::emit<FeesWithdrawn>(v1);
    }

    // decompiled from Move bytecode v6
}

