module 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::kiosk_offer_collection {
    struct CollectionOfferData has store, key {
        id: 0x2::object::UID,
        current_id: u64,
    }

    struct AcceptedItem<phantom T0: store + key> has store {
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        purchase_cap: 0x2::kiosk::PurchaseCap<T0>,
    }

    struct CollectionOfferItem<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        offerer: address,
        collection_offer_id: u64,
        collection_type: 0x1::string::String,
        quantity: u64,
        price_per_item: u64,
        paids: 0x2::coin::Coin<0x2::sui::SUI>,
        accepted_items: 0x2::vec_map::VecMap<0x2::object::ID, AcceptedItem<T0>>,
        nft_ids: vector<0x2::object::ID>,
    }

    struct BidderBag has store, key {
        id: 0x2::object::UID,
    }

    struct OfferCollectionEvent has copy, drop, store {
        collection_offer_id: u64,
        collection_type: 0x1::string::String,
        offerer: address,
        quantity: u64,
        price_per_item: u64,
        amount_paid: u64,
    }

    struct CancelOfferCollectionEvent has copy, drop, store {
        collection_offer_id: u64,
        collection_type: 0x1::string::String,
        offerer: address,
        quantity: u64,
        price_per_item: u64,
        amount_recived: u64,
    }

    struct AcceptOfferCollectionEvent has copy, drop, store {
        collection_offer_id: u64,
        nft_id: 0x2::object::ID,
        collection_type: 0x1::string::String,
        accepter: address,
        accepter_kiosk: 0x2::object::ID,
        remain_quantity: u64,
        price_per_item: u64,
    }

    struct ClaimNFTEvent has copy, drop, store {
        collection_offer_id: u64,
        nft_id: 0x2::object::ID,
        collection_type: 0x1::string::String,
    }

    public fun accept_offer_collection<T0: store + key>(arg0: &mut 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::kiosk_trade::Market, arg1: &mut CollectionOfferData, arg2: u64, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun accept_offer_collection_v2<T0: store + key>(arg0: &mut 0xc51203fb802e09f7bdb87e8433ea2fa4a19068164040f5fac284a032ee433e7a::kiosk_trade::Market, arg1: &mut CollectionOfferData, arg2: &mut BidderBag, arg3: u64, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun cancel_offer_collection<T0: store + key>(arg0: &mut CollectionOfferData, arg1: u64, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun cancel_offer_collection_v2<T0: store + key>(arg0: &mut CollectionOfferData, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun claim_nft<T0: store + key>(arg0: &mut CollectionOfferData, arg1: u64, arg2: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun claim_nft_v2<T0: store + key>(arg0: &mut CollectionOfferData, arg1: &mut BidderBag, arg2: u64, arg3: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: 0x2::object::ID, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun create_bidder_bag(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 5);
        let v0 = BidderBag{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<BidderBag>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectionOfferData{
            id         : 0x2::object::new(arg0),
            current_id : 0,
        };
        0x2::transfer::public_share_object<CollectionOfferData>(v0);
        let v1 = BidderBag{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<BidderBag>(v1);
    }

    public fun offer_collection<T0: store + key>(arg0: &mut CollectionOfferData, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public entry fun offer_collection_v2<T0: store + key>(arg0: &mut CollectionOfferData, arg1: &mut BidderBag, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

