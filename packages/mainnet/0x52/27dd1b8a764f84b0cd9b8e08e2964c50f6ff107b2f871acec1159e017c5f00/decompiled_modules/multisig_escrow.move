module 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig_escrow {
    struct MULTISIG_ESCROW has drop {
        dummy_field: bool,
    }

    struct Listings has store, key {
        id: 0x2::object::UID,
        signer_public_key: vector<u8>,
        fee_recipient: address,
        fee_rate: u64,
        warranty_price_recipient: address,
        supporting_coin_types: 0x2::vec_set::VecSet<0x1::string::String>,
        used_db_pks: 0x2::vec_set::VecSet<u64>,
        version: u64,
        paused: bool,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        seller_address: address,
        seller_public_key: vector<u8>,
        coin_type_name: 0x1::string::String,
        price: u64,
        asset: AssetInfo,
        available_amount: u64,
        in_escrow_amount: u64,
        version: u64,
    }

    struct AdminListingCap has store, key {
        id: 0x2::object::UID,
    }

    struct Bid has store, key {
        id: 0x2::object::UID,
        buyer_address: address,
        listing_id: 0x2::object::ID,
        price: u64,
        amount: u64,
        total_paid_amount: u64,
        applied_discount_rate: u64,
    }

    struct Discount has store, key {
        id: 0x2::object::UID,
        listing_id: 0x2::object::ID,
        seller_address: address,
        min_amount: u64,
        discount_rate: u64,
        version: u64,
    }

    struct AssetInfo has copy, drop, store {
        asset_id: 0x1::string::String,
        asset_type: 0x1::string::String,
        asset_group_id: 0x1::string::String,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct Escrow<phantom T0> has store, key {
        id: 0x2::object::UID,
        listing_id: 0x2::object::ID,
        bid: Bid,
        seller_address: address,
        operator: address,
        payment: 0x1::option::Option<0x2::coin::Coin<T0>>,
        fulfilled: bool,
        fee_recipient: address,
        fee_amount: u64,
        buyer_warranty: 0x1::option::Option<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::Warranty>,
        warranty_price_recipient: address,
        asset: AssetInfo,
        version: u64,
    }

    struct MessageRegistry has store, key {
        id: 0x2::object::UID,
        used_hashes: 0x2::table::Table<vector<u8>, bool>,
    }

    struct VersionRegistry has store, key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::table::Table<u64, bool>,
    }

    struct ListingCreated has copy, drop {
        listing_id: 0x2::object::ID,
        seller_address: address,
        coin_type_name: 0x1::string::String,
        db_pk: u64,
        price: u64,
        amount: u64,
        asset: AssetInfo,
    }

    struct ListingUpdated has copy, drop {
        listing_id: 0x2::object::ID,
        seller_address: address,
        coin_type_name: 0x1::string::String,
        price: u64,
        amount: u64,
        asset: AssetInfo,
    }

    struct ListingCanceled has copy, drop {
        listing_id: 0x2::object::ID,
        seller_address: address,
        coin_type_name: 0x1::string::String,
        price: u64,
        amount: u64,
        asset: AssetInfo,
    }

    struct EscrowCreatedV3 has copy, drop {
        escrow_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        bid_id: 0x2::object::ID,
        seller_address: address,
        buyer_address: address,
        operator: address,
        coin_type_name: 0x1::string::String,
        price: u64,
        quantity: u64,
        total_paid_amount: u64,
        total_volume: u64,
        applied_discount_rate: u64,
        asset: AssetInfo,
        debt_amount: u64,
        debt_pk: u64,
        debt_pool_id: 0x1::option::Option<0x2::object::ID>,
        pia_amount: u64,
        pia_pk: 0x1::string::String,
        pia_pool_id: 0x1::option::Option<0x2::object::ID>,
        checkout_id: 0x1::string::String,
    }

    struct EscrowCanceledV3 has copy, drop {
        escrow_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        seller_address: address,
        buyer_address: address,
        coin_type_name: 0x1::string::String,
        price: u64,
        quantity: u64,
        total_paid_amount: u64,
        total_volume: u64,
        applied_discount_rate: u64,
        asset: AssetInfo,
        debt_amount: u64,
        debt_pk: u64,
        debt_pool_id: 0x1::option::Option<0x2::object::ID>,
        pia_amount: u64,
        pia_pk: 0x1::string::String,
        pia_pool_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct EscrowFulfilledV3 has copy, drop {
        escrow_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        seller_address: address,
        buyer_address: address,
        coin_type_name: 0x1::string::String,
        price: u64,
        quantity: u64,
        total_paid_amount: u64,
        total_volume: u64,
        applied_discount_rate: u64,
        asset: AssetInfo,
        debt_amount: u64,
        debt_pk: u64,
        debt_pool_id: 0x1::option::Option<0x2::object::ID>,
        pia_amount: u64,
        pia_pk: 0x1::string::String,
        pia_pool_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct DiscountAdded has copy, drop {
        listing_id: 0x2::object::ID,
        discount_id: 0x2::object::ID,
        min_amount: u64,
        discount_rate: u64,
    }

    struct DiscountRemoved has copy, drop {
        listing_id: 0x2::object::ID,
        discount_id: 0x2::object::ID,
        min_amount: u64,
        discount_rate: u64,
    }

    struct EscrowCreated has copy, drop {
        escrow_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        bid_id: 0x2::object::ID,
        seller_address: address,
        buyer_address: address,
        operator: address,
        coin_type_name: 0x1::string::String,
        price: u64,
        quantity: u64,
        total_paid_amount: u64,
        applied_discount_rate: u64,
        asset: AssetInfo,
    }

    struct EscrowCreatedV2 has copy, drop {
        escrow_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        bid_id: 0x2::object::ID,
        seller_address: address,
        buyer_address: address,
        operator: address,
        coin_type_name: 0x1::string::String,
        price: u64,
        quantity: u64,
        total_paid_amount: u64,
        total_volume: u64,
        applied_discount_rate: u64,
        asset: AssetInfo,
        debt_amount: u64,
        debt_pk: u64,
        debt_pool_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct EscrowCanceled has copy, drop {
        escrow_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        seller_address: address,
        buyer_address: address,
        coin_type_name: 0x1::string::String,
        price: u64,
        quantity: u64,
        total_paid_amount: u64,
        applied_discount_rate: u64,
        asset: AssetInfo,
    }

    struct EscrowCanceledV2 has copy, drop {
        escrow_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        seller_address: address,
        buyer_address: address,
        coin_type_name: 0x1::string::String,
        price: u64,
        quantity: u64,
        total_paid_amount: u64,
        total_volume: u64,
        applied_discount_rate: u64,
        asset: AssetInfo,
        debt_amount: u64,
        debt_pk: u64,
        debt_pool_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct EscrowFulfilled has copy, drop {
        escrow_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        seller_address: address,
        buyer_address: address,
        coin_type_name: 0x1::string::String,
        price: u64,
        quantity: u64,
        total_paid_amount: u64,
        applied_discount_rate: u64,
        asset: AssetInfo,
    }

    struct EscrowFulfilledV2 has copy, drop {
        escrow_id: 0x2::object::ID,
        listing_id: 0x2::object::ID,
        seller_address: address,
        buyer_address: address,
        coin_type_name: 0x1::string::String,
        price: u64,
        quantity: u64,
        total_paid_amount: u64,
        total_volume: u64,
        applied_discount_rate: u64,
        asset: AssetInfo,
        debt_amount: u64,
        debt_pk: u64,
        debt_pool_id: 0x1::option::Option<0x2::object::ID>,
    }

    public(friend) fun add_allowed_version(arg0: &mut Listings, arg1: u64) {
        0x2::table::add<u64, bool>(&mut 0x2::dynamic_object_field::borrow_mut<vector<u8>, VersionRegistry>(&mut arg0.id, b"version_registry").allowed_versions, arg1, true);
    }

    public fun add_discount(arg0: &Listings, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        check_package_available(arg0);
        assert!(0x2::dynamic_object_field::borrow<0x2::object::ID, Listing>(&arg0.id, arg1).seller_address == 0x2::tx_context::sender(arg4), 1);
        validate_discount_rate(arg3);
        let v0 = Discount{
            id             : 0x2::object::new(arg4),
            listing_id     : arg1,
            seller_address : 0x2::tx_context::sender(arg4),
            min_amount     : arg2,
            discount_rate  : arg3,
            version        : 4,
        };
        0x2::transfer::public_share_object<Discount>(v0);
        let v1 = DiscountAdded{
            listing_id    : arg1,
            discount_id   : 0x2::object::id<Discount>(&v0),
            min_amount    : arg2,
            discount_rate : arg3,
        };
        0x2::event::emit<DiscountAdded>(v1);
    }

    public(friend) fun add_supporting_coin_type(arg0: &mut Listings, arg1: 0x1::string::String) {
        0x2::vec_set::insert<0x1::string::String>(&mut arg0.supporting_coin_types, arg1);
    }

    entry fun burn_admin_listing_cap(arg0: AdminListingCap) {
        let AdminListingCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun calculate_discount_amount(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 10000, 12);
        0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::math::safe_div_u64(0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::math::safe_mul_u64(arg0, arg1), 10000)
    }

    fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 10000, 12);
        0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::math::safe_div_u64(0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::math::safe_mul_u64(arg0, arg1), 10000)
    }

    public fun cancel_escrow<T0>(arg0: &mut Listings, arg1: Escrow<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        abort 109
    }

    public fun cancel_escrow_v3<T0>(arg0: &mut Listings, arg1: Escrow<T0>, arg2: &0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::PiaRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        check_package_available(arg0);
        assert!(arg1.fulfilled == false, 5);
        assert!(arg1.operator == 0x2::tx_context::sender(arg3), 10);
        assert!(arg1.version == 4, 106);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::option::none<0x2::object::ID>();
        let v3 = 0;
        let v4 = 0x1::string::utf8(b"");
        let v5 = 0x1::option::none<0x2::object::ID>();
        let Escrow {
            id                       : v6,
            listing_id               : v7,
            bid                      : v8,
            seller_address           : _,
            operator                 : _,
            payment                  : v11,
            fulfilled                : _,
            fee_recipient            : _,
            fee_amount               : _,
            buyer_warranty           : v15,
            warranty_price_recipient : _,
            asset                    : v17,
            version                  : _,
        } = arg1;
        let v19 = v15;
        let v20 = v11;
        let v21 = v8;
        let v22 = v6;
        if (0x2::dynamic_field::exists_<vector<u8>>(&v22, b"debt")) {
            let v23 = 0x2::dynamic_field::remove<vector<u8>, 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::Debt>(&mut v22, b"debt");
            let (_, v25, v26, _, _, v29) = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::get_debt(&v23);
            v2 = 0x1::option::some<0x2::object::ID>(v26);
            v1 = v29;
            v0 = v25;
            0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::delete_debt(v23);
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&v22, b"pia")) {
            let v30 = 0x2::dynamic_field::remove<vector<u8>, 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::Pia>(&mut v22, b"pia");
            let (_, v32, _, _, v35) = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::get_pia(&v30);
            v5 = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::try_get_pool_id<T0>(arg2);
            v4 = v35;
            v3 = v32;
            0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::delete_pia(v30);
        };
        let v36 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, v7);
        v36.available_amount = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::math::safe_add_u64(v36.available_amount, v21.amount);
        v36.in_escrow_amount = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::math::safe_sub_u64(v36.in_escrow_amount, v21.amount);
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v20)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut v20), v21.buyer_address);
        };
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v20);
        let Bid {
            id                    : v37,
            buyer_address         : v38,
            listing_id            : _,
            price                 : v40,
            amount                : v41,
            total_paid_amount     : v42,
            applied_discount_rate : v43,
        } = v21;
        0x2::object::delete(v37);
        0x2::object::delete(v22);
        let v44 = v42;
        if (0x1::option::is_some<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::Warranty>(&v19)) {
            let v45 = 0x1::option::extract<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::Warranty>(&mut v19);
            v44 = v42 - 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::price(&v45);
            0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::delete(v45);
        };
        0x1::option::destroy_none<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::Warranty>(v19);
        let v46 = EscrowCanceledV3{
            escrow_id             : 0x2::object::id<Escrow<T0>>(&arg1),
            listing_id            : v7,
            seller_address        : v36.seller_address,
            buyer_address         : v38,
            coin_type_name        : v36.coin_type_name,
            price                 : v40,
            quantity              : v41,
            total_paid_amount     : v42,
            total_volume          : v44,
            applied_discount_rate : v43,
            asset                 : v17,
            debt_amount           : v0,
            debt_pk               : v1,
            debt_pool_id          : v2,
            pia_amount            : v3,
            pia_pk                : v4,
            pia_pool_id           : v5,
        };
        0x2::event::emit<EscrowCanceledV3>(v46);
    }

    public fun cancel_listing(arg0: &mut Listings, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        check_package_available(arg0);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Listing>(&arg0.id, arg1);
        assert!(v0.seller_address == 0x2::tx_context::sender(arg2), 1);
        assert!(v0.in_escrow_amount == 0, 11);
        delete_listing(arg0, arg1);
    }

    fun check_and_mark_message(arg0: &mut Listings, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>) {
        assert!(0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, b"message_registry"), 4);
        verify_args(arg1, arg0.signer_public_key, arg2);
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, MessageRegistry>(&mut arg0.id, b"message_registry");
        0x1::vector::append<u8>(&mut arg3, arg1);
        let v1 = 0x1::hash::sha3_256(arg3);
        assert!(!0x2::table::contains<vector<u8>, bool>(&v0.used_hashes, v1), 108);
        0x2::table::add<vector<u8>, bool>(&mut v0.used_hashes, v1, true);
    }

    fun check_coin_type_match<T0>(arg0: 0x1::string::String) {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        assert!(arg0 == v0, 2);
    }

    fun check_package_available(arg0: &Listings) {
        assert!(check_version(arg0), 106);
        check_paused(arg0);
    }

    fun check_paused(arg0: &Listings) {
        assert!(!arg0.paused, 107);
    }

    fun check_version(arg0: &Listings) : bool {
        0x2::table::contains<u64, bool>(&0x2::dynamic_object_field::borrow<vector<u8>, VersionRegistry>(&arg0.id, b"version_registry").allowed_versions, 4)
    }

    public fun create_escrow_review<T0>(arg0: &mut Escrow<T0>, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 1 && arg1 <= 5, 7);
        assert!(0x1::string::length(&arg2) > 0, 8);
        assert!(arg0.seller_address == 0x2::tx_context::sender(arg3) || arg0.bid.buyer_address == 0x2::tx_context::sender(arg3), 6);
        assert!(arg0.fulfilled == true, 9);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (arg0.seller_address == v0) {
            arg0.bid.buyer_address
        } else {
            arg0.seller_address
        };
        let (v2, v3) = if (arg0.seller_address == v0) {
            0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::review::review_side_seller()
        } else {
            0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::review::review_side_buyer()
        };
        let v4 = arg0.asset;
        0x2::dynamic_field::add<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::review::ReviewKey, 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::review::Review>(&mut arg0.id, v3, 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::review::create_review(v0, v1, 0x2::object::id<Escrow<T0>>(arg0), v2, v4.asset_id, v4.asset_type, v4.asset_group_id, arg1, arg2, arg3));
    }

    fun decode_message(arg0: vector<u8>) : (u64, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_u64(&mut v0), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)))
    }

    fun delete_listing(arg0: &mut Listings, arg1: 0x2::object::ID) {
        let Listing {
            id                : v0,
            seller_address    : v1,
            seller_public_key : _,
            coin_type_name    : v3,
            price             : v4,
            asset             : v5,
            available_amount  : v6,
            in_escrow_amount  : _,
            version           : _,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        0x2::object::delete(v0);
        let v9 = ListingCanceled{
            listing_id     : arg1,
            seller_address : v1,
            coin_type_name : v3,
            price          : v4,
            amount         : v6,
            asset          : v5,
        };
        0x2::event::emit<ListingCanceled>(v9);
    }

    public fun fulfill_escrow<T0>(arg0: &mut Listings, arg1: &mut Escrow<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        abort 109
    }

    public fun fulfill_escrow_v2<T0>(arg0: &mut Listings, arg1: &mut Escrow<T0>, arg2: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::PoolRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        abort 109
    }

    public fun fulfill_escrow_v3<T0>(arg0: &mut Listings, arg1: &mut Escrow<T0>, arg2: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::PoolRegistry, arg3: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::PiaRegistry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_package_available(arg0);
        assert!(arg1.fulfilled == false, 5);
        assert!(arg1.operator == 0x2::tx_context::sender(arg5), 10);
        assert!(arg1.version == 4, 106);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, arg1.listing_id);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0x1::option::none<0x2::object::ID>();
        let v4 = 0;
        let v5 = 0x1::string::utf8(b"");
        let v6 = 0x1::option::none<0x2::object::ID>();
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg1.payment)) {
            let v7 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg1.payment);
            if (0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"debt")) {
                let v8 = 0x2::dynamic_field::remove<vector<u8>, 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::Debt>(&mut arg1.id, b"debt");
                let (_, v10, v11, _, _, v14) = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::get_debt(&v8);
                v3 = 0x1::option::some<0x2::object::ID>(v11);
                v2 = v14;
                v1 = v10;
                0x2::coin::join<T0>(&mut v7, 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::use_debt<T0>(arg2, v8, arg5));
            };
            if (0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, b"pia")) {
                let v15 = 0x2::dynamic_field::remove<vector<u8>, 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::Pia>(&mut arg1.id, b"pia");
                let (_, v17, _, _, v20) = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::get_pia(&v15);
                v4 = v17;
                v5 = v20;
                v6 = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::try_get_pool_id<T0>(arg3);
                0x2::coin::join<T0>(&mut v7, 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::use_pia<T0>(arg3, v15, arg5));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v7, arg1.fee_amount, arg5), arg1.fee_recipient);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, v0.seller_address);
        };
        v0.in_escrow_amount = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::math::safe_sub_u64(v0.in_escrow_amount, arg1.bid.amount);
        let v21 = EscrowFulfilledV3{
            escrow_id             : 0x2::object::id<Escrow<T0>>(arg1),
            listing_id            : arg1.listing_id,
            seller_address        : v0.seller_address,
            buyer_address         : arg1.bid.buyer_address,
            coin_type_name        : v0.coin_type_name,
            price                 : arg1.bid.price,
            quantity              : arg1.bid.amount,
            total_paid_amount     : arg1.bid.total_paid_amount,
            total_volume          : arg1.bid.total_paid_amount,
            applied_discount_rate : arg1.bid.applied_discount_rate,
            asset                 : arg1.asset,
            debt_amount           : v1,
            debt_pk               : v2,
            debt_pool_id          : v3,
            pia_amount            : v4,
            pia_pk                : v5,
            pia_pool_id           : v6,
        };
        0x2::event::emit<EscrowFulfilledV3>(v21);
        arg1.fulfilled = true;
    }

    fun get_operator(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : address {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, arg0);
        0x1::vector::push_back<vector<u8>>(v1, arg1);
        0x1::vector::push_back<vector<u8>>(v1, arg2);
        0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::multisig::derive_multisig_address_quiet(v0, x"010101", 2)
    }

    fun init(arg0: MULTISIG_ESCROW, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<MULTISIG_ESCROW>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = Listings{
            id                       : 0x2::object::new(arg1),
            signer_public_key        : b"",
            fee_recipient            : 0x2::tx_context::sender(arg1),
            fee_rate                 : 0,
            warranty_price_recipient : 0x2::tx_context::sender(arg1),
            supporting_coin_types    : 0x2::vec_set::empty<0x1::string::String>(),
            used_db_pks              : 0x2::vec_set::empty<u64>(),
            version                  : 4,
            paused                   : false,
        };
        0x2::transfer::public_share_object<Listings>(v0);
    }

    public fun is_paused(arg0: &Listings) : bool {
        arg0.paused
    }

    public fun is_version_compatible(arg0: &Listings) : bool {
        check_version(arg0)
    }

    public fun list(arg0: &mut Listings, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        list_internal(arg0, arg1, arg2, v0, arg3, arg4, arg5, arg6, arg7);
    }

    public fun list_by_admin(arg0: &mut Listings, arg1: &AdminListingCap, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: vector<u8>, arg6: u64, arg7: 0x1::string::String, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        list_internal(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun list_internal(arg0: &mut Listings, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: vector<u8>, arg5: u64, arg6: 0x1::string::String, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        check_package_available(arg0);
        assert!(0x2::vec_set::contains<0x1::string::String>(&arg0.supporting_coin_types, &arg6), 2);
        assert!(arg7 != 0, 12);
        assert!(arg5 != 0, 13);
        check_and_mark_message(arg0, arg1, arg2, b"listing");
        let (v0, v1, v2, v3, v4, v5) = decode_message(arg1);
        let v6 = AssetInfo{
            asset_id       : v1,
            asset_type     : v2,
            asset_group_id : v3,
            name           : v4,
            image_url      : v5,
        };
        let v7 = Listing{
            id                : 0x2::object::new(arg8),
            seller_address    : arg3,
            seller_public_key : arg4,
            coin_type_name    : arg6,
            price             : arg5,
            asset             : v6,
            available_amount  : arg7,
            in_escrow_amount  : 0,
            version           : 4,
        };
        let v8 = 0x2::object::id<Listing>(&v7);
        0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut arg0.id, v8, v7);
        let v9 = ListingCreated{
            listing_id     : v8,
            seller_address : arg3,
            coin_type_name : arg6,
            db_pk          : v0,
            price          : arg5,
            amount         : arg7,
            asset          : v7.asset,
        };
        0x2::event::emit<ListingCreated>(v9);
    }

    public(friend) fun migrate_create_listing(arg0: &Listings, arg1: address, arg2: vector<u8>, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        abort 109
    }

    public(friend) fun mint_admin_listing_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminListingCap {
        AdminListingCap{id: 0x2::object::new(arg0)}
    }

    public fun new_escrow<T0>(arg0: &mut Listings, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut 0x2::coin::Coin<T0>, arg4: vector<vector<u8>>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        abort 109
    }

    fun new_escrow_internal<T0>(arg0: &mut Listings, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut 0x2::coin::Coin<T0>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::PoolRegistry, arg10: &0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::PiaRegistry, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        check_package_available(arg0);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        let v1 = get_operator(v0.seller_public_key, arg2, arg0.signer_public_key);
        assert!(v0.available_amount >= arg7, 105);
        assert!(arg7 != 0, 12);
        let v2 = 0x2::object::new(arg12);
        let v3 = 0x1::option::none<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::Debt>();
        if (0x1::vector::length<u8>(&arg5) > 0) {
            let v4 = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::create_debt<T0>(arg9, arg5, arg12, arg11);
            let (_, _, _, v8, _, _) = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::get_debt(&v4);
            assert!(v8 == arg1, 112);
            0x1::option::fill<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::Debt>(&mut v3, v4);
        };
        let v11 = 0x1::option::none<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::Pia>();
        if (0x1::vector::length<u8>(&arg6) > 0) {
            let v12 = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::create_pia(arg10, arg6, arg12, arg11);
            let (_, _, v15, _, _) = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::get_pia(&v12);
            assert!(v15 == arg1, 113);
            0x1::option::fill<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::Pia>(&mut v11, v12);
        };
        assert!(0x1::vector::length<u8>(&arg4) > 0, 110);
        let v18 = 0x2::bcs::new(arg4);
        let v19 = 0x2::bcs::peel_address(&mut v18);
        let v20 = v0.coin_type_name;
        check_coin_type_match<T0>(v20);
        let v21 = v0.price;
        let v22 = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::math::safe_mul_u64(v21, arg7);
        let v23 = v22;
        if (arg8 > 0) {
            v23 = v22 - calculate_discount_amount(v22, arg8);
        };
        let v24 = if (0x1::option::is_some<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::Debt>(&v3)) {
            0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::get_debt_amount(0x1::option::borrow<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::Debt>(&v3))
        } else {
            0
        };
        let v25 = if (0x1::option::is_some<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::Pia>(&v11)) {
            0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::get_pia_amount(0x1::option::borrow<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::Pia>(&v11))
        } else {
            0
        };
        assert!(v24 + v25 <= v23, 111);
        let v26 = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::math::safe_sub_u64(0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::math::safe_sub_u64(v23, v24), v25);
        assert!(0x2::balance::value<T0>(0x2::coin::balance<T0>(arg3)) >= v26, 3);
        let v27 = v0.asset;
        let v28 = Bid{
            id                    : 0x2::object::new(arg12),
            buyer_address         : v19,
            listing_id            : arg1,
            price                 : v21,
            amount                : arg7,
            total_paid_amount     : v23,
            applied_discount_rate : arg8,
        };
        v0.available_amount = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::math::safe_sub_u64(v0.available_amount, arg7);
        v0.in_escrow_amount = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::math::safe_add_u64(v0.in_escrow_amount, arg7);
        let v29 = Escrow<T0>{
            id                       : v2,
            listing_id               : arg1,
            bid                      : v28,
            seller_address           : v0.seller_address,
            operator                 : v1,
            payment                  : 0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg3, v26, arg12)),
            fulfilled                : false,
            fee_recipient            : arg0.fee_recipient,
            fee_amount               : calculate_fee(v23, arg0.fee_rate),
            buyer_warranty           : 0x1::option::none<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::Warranty>(),
            warranty_price_recipient : arg0.warranty_price_recipient,
            asset                    : v27,
            version                  : 4,
        };
        let v30 = 0;
        let v31 = 0;
        let v32 = 0x1::option::none<0x2::object::ID>();
        if (0x1::option::is_some<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::Debt>(&v3)) {
            let v33 = 0x1::option::extract<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::Debt>(&mut v3);
            assert!(0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::get_debt_user(&v33) == v19, 114);
            let (_, v35, v36, _, _, v39) = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::get_debt(&v33);
            v30 = v35;
            v31 = v39;
            v32 = 0x1::option::some<0x2::object::ID>(v36);
            0x2::dynamic_field::add<vector<u8>, 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::Debt>(&mut v29.id, b"debt", v33);
        };
        0x1::option::destroy_none<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::Debt>(v3);
        let v40 = 0;
        let v41 = 0x1::string::utf8(b"");
        let v42 = 0x1::option::none<0x2::object::ID>();
        if (0x1::option::is_some<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::Pia>(&v11)) {
            let v43 = 0x1::option::extract<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::Pia>(&mut v11);
            assert!(0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::get_pia_user(&v43) == v19, 114);
            let (_, v45, _, _, v48) = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::get_pia(&v43);
            v40 = v45;
            v41 = v48;
            v42 = 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::try_get_pool_id<T0>(arg10);
            0x2::dynamic_field::add<vector<u8>, 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::Pia>(&mut v29.id, b"pia", v43);
        };
        0x1::option::destroy_none<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::Pia>(v11);
        let v49 = EscrowCreatedV3{
            escrow_id             : 0x2::object::uid_to_inner(&v2),
            listing_id            : arg1,
            bid_id                : 0x2::object::id<Bid>(&v28),
            seller_address        : v0.seller_address,
            buyer_address         : v19,
            operator              : v1,
            coin_type_name        : v20,
            price                 : v21,
            quantity              : arg7,
            total_paid_amount     : v23,
            total_volume          : v23,
            applied_discount_rate : arg8,
            asset                 : v27,
            debt_amount           : v30,
            debt_pk               : v31,
            debt_pool_id          : v32,
            pia_amount            : v40,
            pia_pk                : v41,
            pia_pool_id           : v42,
            checkout_id           : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v18)),
        };
        0x2::event::emit<EscrowCreatedV3>(v49);
        0x2::transfer::public_share_object<Escrow<T0>>(v29);
    }

    public fun new_escrow_v2<T0>(arg0: &mut Listings, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut 0x2::coin::Coin<T0>, arg4: vector<vector<u8>>, arg5: u64, arg6: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::PoolRegistry, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        abort 109
    }

    public fun new_escrow_v3<T0>(arg0: &mut Listings, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut 0x2::coin::Coin<T0>, arg4: vector<vector<u8>>, arg5: u64, arg6: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::PoolRegistry, arg7: &0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::PiaRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = validate_and_extract_extra_message(arg4, arg0);
        new_escrow_internal<T0>(arg0, arg1, arg2, arg3, v0, v1, v2, arg5, 0, arg6, arg7, arg8, arg9);
    }

    public fun new_escrow_with_discount<T0>(arg0: &mut Listings, arg1: 0x2::object::ID, arg2: &Discount, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<T0>, arg5: vector<vector<u8>>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        abort 109
    }

    public fun new_escrow_with_discount_v2<T0>(arg0: &mut Listings, arg1: 0x2::object::ID, arg2: &Discount, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<T0>, arg5: vector<vector<u8>>, arg6: u64, arg7: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::PoolRegistry, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        abort 109
    }

    public fun new_escrow_with_discount_v3<T0>(arg0: &mut Listings, arg1: 0x2::object::ID, arg2: &Discount, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<T0>, arg5: vector<vector<u8>>, arg6: u64, arg7: &mut 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::debt::PoolRegistry, arg8: &0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::pia::PiaRegistry, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.listing_id == arg1, 2);
        assert!(arg2.min_amount <= arg6, 105);
        let (v0, v1, v2) = validate_and_extract_extra_message(arg5, arg0);
        new_escrow_internal<T0>(arg0, arg1, arg3, arg4, v0, v1, v2, arg6, arg2.discount_rate, arg7, arg8, arg9, arg10);
    }

    public(friend) fun remove_allowed_version(arg0: &mut Listings, arg1: u64) {
        0x2::table::remove<u64, bool>(&mut 0x2::dynamic_object_field::borrow_mut<vector<u8>, VersionRegistry>(&mut arg0.id, b"version_registry").allowed_versions, arg1);
    }

    public fun remove_discount(arg0: &Listings, arg1: Discount, arg2: &mut 0x2::tx_context::TxContext) {
        check_package_available(arg0);
        assert!(arg1.seller_address == 0x2::tx_context::sender(arg2), 1);
        let Discount {
            id             : v0,
            listing_id     : _,
            seller_address : _,
            min_amount     : v3,
            discount_rate  : v4,
            version        : _,
        } = arg1;
        0x2::object::delete(v0);
        let v6 = DiscountRemoved{
            listing_id    : arg1.listing_id,
            discount_id   : 0x2::object::id<Discount>(&arg1),
            min_amount    : v3,
            discount_rate : v4,
        };
        0x2::event::emit<DiscountRemoved>(v6);
    }

    public(friend) fun remove_supporting_coin_type(arg0: &mut Listings, arg1: 0x1::string::String) {
        0x2::vec_set::remove<0x1::string::String>(&mut arg0.supporting_coin_types, &arg1);
    }

    public(friend) fun set_fee_rate(arg0: &mut Listings, arg1: u64) {
        validate_fee_rate(arg1);
        arg0.fee_rate = arg1;
    }

    public(friend) fun set_fee_recipient(arg0: &mut Listings, arg1: address) {
        arg0.fee_recipient = arg1;
    }

    public(friend) fun set_message_registry(arg0: &mut Listings, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MessageRegistry{
            id          : 0x2::object::new(arg1),
            used_hashes : 0x2::table::new<vector<u8>, bool>(arg1),
        };
        0x2::dynamic_object_field::add<vector<u8>, MessageRegistry>(&mut arg0.id, b"message_registry", v0);
    }

    public(friend) fun set_paused(arg0: &mut Listings, arg1: bool) {
        arg0.paused = arg1;
    }

    public(friend) fun set_signer_public_key(arg0: &mut Listings, arg1: vector<u8>) {
        arg0.signer_public_key = arg1;
    }

    public(friend) fun set_version(arg0: &mut Listings, arg1: u64) {
        arg0.version = arg1;
    }

    public(friend) fun set_version_registry(arg0: &mut Listings, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VersionRegistry{
            id               : 0x2::object::new(arg1),
            allowed_versions : 0x2::table::new<u64, bool>(arg1),
        };
        0x2::table::add<u64, bool>(&mut v0.allowed_versions, 4, true);
        0x2::dynamic_object_field::add<vector<u8>, VersionRegistry>(&mut arg0.id, b"version_registry", v0);
    }

    public(friend) fun set_warranty_price_recipient(arg0: &mut Listings, arg1: address) {
        arg0.warranty_price_recipient = arg1;
    }

    public fun update_listing(arg0: &mut Listings, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::tx_context::TxContext) {
        update_listing_internal(arg0, arg1, arg2, arg3, arg4, arg5, 0x1::option::some<address>(0x2::tx_context::sender(arg6)));
    }

    public fun update_listing_by_admin(arg0: &mut Listings, arg1: &AdminListingCap, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::tx_context::TxContext) {
        update_listing_internal(arg0, arg2, arg3, arg4, arg5, arg6, 0x1::option::none<address>());
    }

    fun update_listing_internal(arg0: &mut Listings, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::option::Option<address>) {
        check_package_available(arg0);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        if (0x1::option::is_some<address>(&arg6)) {
            assert!(v0.seller_address == 0x1::option::extract<address>(&mut arg6), 1);
        };
        0x1::option::destroy_none<address>(arg6);
        assert!(arg2 != 0, 13);
        v0.price = arg2;
        v0.available_amount = arg3;
        v0.asset.name = arg4;
        v0.asset.image_url = arg5;
        let v1 = ListingUpdated{
            listing_id     : arg1,
            seller_address : v0.seller_address,
            coin_type_name : v0.coin_type_name,
            price          : arg2,
            amount         : arg3,
            asset          : v0.asset,
        };
        0x2::event::emit<ListingUpdated>(v1);
    }

    fun validate_and_extract_extra_message(arg0: vector<vector<u8>>, arg1: &mut Listings) : (vector<u8>, vector<u8>, vector<u8>) {
        assert!(0x1::vector::length<vector<u8>>(&arg0) == 6, 110);
        check_and_mark_message(arg1, *0x1::vector::borrow<vector<u8>>(&arg0, 0), *0x1::vector::borrow<vector<u8>>(&arg0, 1), b"escrow");
        if (0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg0, 2)) > 0) {
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg0, 3)) > 0, 110);
            check_and_mark_message(arg1, *0x1::vector::borrow<vector<u8>>(&arg0, 2), *0x1::vector::borrow<vector<u8>>(&arg0, 3), b"debt");
        };
        if (0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg0, 4)) > 0) {
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(&arg0, 4)) > 0, 110);
            check_and_mark_message(arg1, *0x1::vector::borrow<vector<u8>>(&arg0, 4), *0x1::vector::borrow<vector<u8>>(&arg0, 5), b"pia");
        };
        (*0x1::vector::borrow<vector<u8>>(&arg0, 0), *0x1::vector::borrow<vector<u8>>(&arg0, 2), *0x1::vector::borrow<vector<u8>>(&arg0, 4))
    }

    fun validate_discount_rate(arg0: u64) {
        assert!(arg0 <= 10000, 12);
    }

    fun validate_fee_rate(arg0: u64) {
        assert!(arg0 <= 10000, 12);
    }

    fun verify_args(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 1;
        loop {
            if (v1 == 33) {
                break
            };
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg1, v1));
            v1 = v1 + 1;
        };
        assert!(0x2::ed25519::ed25519_verify(&arg2, &v0, &arg0), 102);
    }

    // decompiled from Move bytecode v6
}

