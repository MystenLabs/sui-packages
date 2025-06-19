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

    public fun add_discount(arg0: &Listings, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        check_package_available(arg0);
        assert!(0x2::dynamic_object_field::borrow<0x2::object::ID, Listing>(&arg0.id, arg1).seller_address == 0x2::tx_context::sender(arg4), 1);
        assert!(arg3 <= 10000, 103);
        let v0 = Discount{
            id             : 0x2::object::new(arg4),
            listing_id     : arg1,
            seller_address : 0x2::tx_context::sender(arg4),
            min_amount     : arg2,
            discount_rate  : arg3,
            version        : 2,
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

    fun calculate_discount_amount(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 10000, 103);
        let v0 = (arg0 as u256) * (arg1 as u256) / (10000 as u256);
        assert!(v0 <= 18446744073709551615, 103);
        (v0 as u64)
    }

    fun calculate_fee(arg0: u64, arg1: u64) : u64 {
        assert!(arg1 <= 10000, 103);
        let v0 = (arg0 as u256) * (arg1 as u256) / (10000 as u256);
        assert!(v0 <= 18446744073709551615, 103);
        (v0 as u64)
    }

    public fun cancel_escrow<T0>(arg0: &mut Listings, arg1: Escrow<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 107);
        assert!(arg0.version == 2, 106);
        assert!(arg1.fulfilled == false, 5);
        assert!(arg1.operator == 0x2::tx_context::sender(arg2), 10);
        assert!(arg1.version == 2, 106);
        let Escrow {
            id                       : v0,
            listing_id               : v1,
            bid                      : v2,
            seller_address           : _,
            operator                 : _,
            payment                  : v5,
            fulfilled                : _,
            fee_recipient            : _,
            fee_amount               : _,
            buyer_warranty           : v9,
            warranty_price_recipient : _,
            asset                    : _,
            version                  : _,
        } = arg1;
        let v13 = v9;
        let v14 = v5;
        let v15 = v2;
        let v16 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, v1);
        v16.available_amount = safe_add_u64(v16.available_amount, v15.amount);
        v16.in_escrow_amount = safe_sub_u64(v16.in_escrow_amount, v15.amount);
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&v14)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x1::option::extract<0x2::coin::Coin<T0>>(&mut v14), v15.buyer_address);
        };
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v14);
        let Bid {
            id                    : v17,
            buyer_address         : v18,
            listing_id            : _,
            price                 : _,
            amount                : v21,
            total_paid_amount     : v22,
            applied_discount_rate : v23,
        } = v15;
        0x2::object::delete(v17);
        0x2::object::delete(v0);
        if (0x1::option::is_some<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::Warranty>(&v13)) {
            0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::delete(0x1::option::extract<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::Warranty>(&mut v13));
        };
        0x1::option::destroy_none<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::Warranty>(v13);
        let v24 = EscrowCanceled{
            escrow_id             : 0x2::object::id<Escrow<T0>>(&arg1),
            listing_id            : v1,
            seller_address        : v16.seller_address,
            buyer_address         : v18,
            coin_type_name        : v16.coin_type_name,
            price                 : v16.price,
            quantity              : v21,
            total_paid_amount     : v22,
            applied_discount_rate : v23,
            asset                 : v16.asset,
        };
        0x2::event::emit<EscrowCanceled>(v24);
    }

    public fun cancel_listing(arg0: &mut Listings, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        check_package_available(arg0);
        let v0 = 0x2::dynamic_object_field::borrow<0x2::object::ID, Listing>(&arg0.id, arg1);
        assert!(v0.seller_address == 0x2::tx_context::sender(arg2), 1);
        assert!(v0.in_escrow_amount == 0, 11);
        delete_listing(arg0, arg1);
    }

    fun check_coin_type_match<T0>(arg0: 0x1::string::String) {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        assert!(arg0 == v0, 2);
    }

    fun check_package_available(arg0: &Listings) {
        check_version(arg0);
        check_paused(arg0);
    }

    fun check_paused(arg0: &Listings) {
        assert!(!arg0.paused, 107);
    }

    fun check_version(arg0: &Listings) {
        assert!(arg0.version == 2, 106);
    }

    public fun create_escrow_review<T0>(arg0: &mut Escrow<T0>, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 1 && arg1 <= 5, 7);
        assert!(0x1::string::length(&arg2) > 0, 8);
        assert!(arg0.seller_address == 0x2::tx_context::sender(arg3) || arg0.bid.buyer_address == 0x2::tx_context::sender(arg3), 6);
        assert!(arg0.fulfilled == true, 9);
        assert!(arg0.version == 2, 106);
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
        assert!(!arg0.paused, 107);
        assert!(arg0.version == 2, 106);
        assert!(arg1.fulfilled == false, 5);
        assert!(arg1.operator == 0x2::tx_context::sender(arg3), 10);
        assert!(arg1.version == 2, 106);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, arg1.listing_id);
        if (0x1::option::is_some<0x2::coin::Coin<T0>>(&arg1.payment)) {
            let v1 = 0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg1.payment);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1, arg1.fee_amount, arg3), arg1.fee_recipient);
            if (0x1::option::is_some<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::Warranty>(&arg1.buyer_warranty)) {
                let v2 = 0x1::option::extract<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::Warranty>(&mut arg1.buyer_warranty);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v1, 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::price(&v2), arg3), arg1.warranty_price_recipient);
                0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::transfer_to_beneficiary(v2, 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::activate_warranty(&mut v2, arg2));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v0.seller_address);
        };
        v0.in_escrow_amount = safe_sub_u64(v0.in_escrow_amount, arg1.bid.amount);
        let v3 = EscrowFulfilled{
            escrow_id             : 0x2::object::id<Escrow<T0>>(arg1),
            listing_id            : arg1.listing_id,
            seller_address        : v0.seller_address,
            buyer_address         : arg1.bid.buyer_address,
            coin_type_name        : v0.coin_type_name,
            price                 : v0.price,
            quantity              : arg1.bid.amount,
            total_paid_amount     : arg1.bid.total_paid_amount,
            applied_discount_rate : arg1.bid.applied_discount_rate,
            asset                 : v0.asset,
        };
        0x2::event::emit<EscrowFulfilled>(v3);
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
            version                  : 2,
            paused                   : false,
        };
        0x2::transfer::public_share_object<Listings>(v0);
    }

    public fun is_paused(arg0: &Listings) : bool {
        arg0.paused
    }

    public fun list(arg0: &mut Listings, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        check_package_available(arg0);
        assert!(0x2::vec_set::contains<0x1::string::String>(&arg0.supporting_coin_types, &arg5), 2);
        assert!(arg6 != 0, 12);
        assert!(arg4 != 0, 13);
        verify_args(arg1, arg0.signer_public_key, arg2);
        let (v0, v1, v2, v3, v4, v5) = decode_message(arg1);
        let v6 = v0;
        assert!(!0x2::vec_set::contains<u64>(&arg0.used_db_pks, &v6), 0);
        0x2::vec_set::insert<u64>(&mut arg0.used_db_pks, v6);
        let v7 = AssetInfo{
            asset_id       : v1,
            asset_type     : v2,
            asset_group_id : v3,
            name           : v4,
            image_url      : v5,
        };
        let v8 = Listing{
            id                : 0x2::object::new(arg7),
            seller_address    : 0x2::tx_context::sender(arg7),
            seller_public_key : arg3,
            coin_type_name    : arg5,
            price             : arg4,
            asset             : v7,
            available_amount  : arg6,
            in_escrow_amount  : 0,
            version           : 2,
        };
        let v9 = 0x2::object::id<Listing>(&v8);
        0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut arg0.id, v9, v8);
        let v10 = ListingCreated{
            listing_id     : v9,
            seller_address : 0x2::tx_context::sender(arg7),
            coin_type_name : arg5,
            db_pk          : v6,
            price          : arg4,
            amount         : arg6,
            asset          : v8.asset,
        };
        0x2::event::emit<ListingCreated>(v10);
    }

    public(friend) fun migrate_create_listing(arg0: &mut Listings, arg1: address, arg2: vector<u8>, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        check_package_available(arg0);
        let v0 = AssetInfo{
            asset_id       : arg5,
            asset_type     : arg6,
            asset_group_id : arg7,
            name           : arg8,
            image_url      : arg9,
        };
        let v1 = Listing{
            id                : 0x2::object::new(arg12),
            seller_address    : arg1,
            seller_public_key : arg2,
            coin_type_name    : arg3,
            price             : arg4,
            asset             : v0,
            available_amount  : arg10,
            in_escrow_amount  : 0,
            version           : 2,
        };
        let v2 = 0x2::object::id<Listing>(&v1);
        0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut arg0.id, v2, v1);
        let v3 = ListingCreated{
            listing_id     : v2,
            seller_address : 0x2::tx_context::sender(arg12),
            coin_type_name : arg3,
            db_pk          : arg11,
            price          : arg4,
            amount         : arg10,
            asset          : v1.asset,
        };
        0x2::event::emit<ListingCreated>(v3);
        v2
    }

    public fun new_escrow<T0>(arg0: &mut Listings, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut 0x2::coin::Coin<T0>, arg4: vector<vector<u8>>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        new_escrow_internal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0, arg6);
    }

    fun new_escrow_internal<T0>(arg0: &mut Listings, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: &mut 0x2::coin::Coin<T0>, arg4: vector<vector<u8>>, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 107);
        assert!(arg0.version == 2, 106);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        assert!(v0.version == 2, 106);
        let v1 = get_operator(v0.seller_public_key, arg2, arg0.signer_public_key);
        assert!(v0.available_amount >= arg5, 105);
        assert!(arg5 != 0, 12);
        let v2 = 0x2::object::new(arg7);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = 0x1::option::none<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::Warranty>();
        if (0x1::vector::length<vector<u8>>(&arg4) > 0) {
            0x1::option::fill<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::Warranty>(&mut v4, 0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::new_warranty(v3, arg4, arg0.signer_public_key, arg7));
        };
        let v5 = v0.coin_type_name;
        check_coin_type_match<T0>(v5);
        let v6 = v0.price;
        let v7 = safe_mul_u64(v6, arg5);
        let v8 = v7;
        if (arg6 > 0) {
            v8 = v7 - calculate_discount_amount(v7, arg6);
        };
        let v9 = if (0x1::option::is_some<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::Warranty>(&v4)) {
            0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::price(0x1::option::borrow<0x6435e67af83654e55b9ea83334a0c6ee0c80c95b3bb66f856e1658b23830adb2::warranty::Warranty>(&v4))
        } else {
            0
        };
        let v10 = safe_add_u64(v8, v9);
        assert!(0x2::balance::value<T0>(0x2::coin::balance<T0>(arg3)) >= v10, 3);
        let v11 = v0.asset;
        let v12 = Bid{
            id                    : 0x2::object::new(arg7),
            buyer_address         : 0x2::tx_context::sender(arg7),
            listing_id            : arg1,
            price                 : v6,
            amount                : arg5,
            total_paid_amount     : v10,
            applied_discount_rate : arg6,
        };
        v0.available_amount = safe_sub_u64(v0.available_amount, arg5);
        v0.in_escrow_amount = safe_add_u64(v0.in_escrow_amount, arg5);
        let v13 = Escrow<T0>{
            id                       : v2,
            listing_id               : arg1,
            bid                      : v12,
            seller_address           : v0.seller_address,
            operator                 : v1,
            payment                  : 0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg3, v10, arg7)),
            fulfilled                : false,
            fee_recipient            : arg0.fee_recipient,
            fee_amount               : calculate_fee(v8, arg0.fee_rate),
            buyer_warranty           : v4,
            warranty_price_recipient : arg0.warranty_price_recipient,
            asset                    : v11,
            version                  : 2,
        };
        0x2::transfer::public_share_object<Escrow<T0>>(v13);
        let v14 = EscrowCreated{
            escrow_id             : v3,
            listing_id            : arg1,
            bid_id                : 0x2::object::id<Bid>(&v12),
            seller_address        : v0.seller_address,
            buyer_address         : 0x2::tx_context::sender(arg7),
            operator              : v1,
            coin_type_name        : v5,
            price                 : v6,
            quantity              : arg5,
            total_paid_amount     : v10,
            applied_discount_rate : arg6,
            asset                 : v11,
        };
        0x2::event::emit<EscrowCreated>(v14);
    }

    public fun new_escrow_with_discount<T0>(arg0: &mut Listings, arg1: 0x2::object::ID, arg2: &Discount, arg3: vector<u8>, arg4: &mut 0x2::coin::Coin<T0>, arg5: vector<vector<u8>>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.listing_id == arg1, 2);
        assert!(arg2.min_amount <= arg6, 105);
        new_escrow_internal<T0>(arg0, arg1, arg3, arg4, arg5, arg6, arg2.discount_rate, arg7);
    }

    public fun remove_discount(arg0: &Listings, arg1: Discount, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 2, 106);
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

    fun safe_add_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u256) + (arg1 as u256);
        assert!(v0 <= 18446744073709551615, 103);
        (v0 as u64)
    }

    fun safe_mul_u64(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u256) * (arg1 as u256);
        assert!(v0 <= 18446744073709551615, 103);
        (v0 as u64)
    }

    fun safe_sub_u64(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 >= arg1, 104);
        arg0 - arg1
    }

    public(friend) fun set_fee_rate(arg0: &mut Listings, arg1: u64) {
        assert!(arg1 <= 10000, 13906835260970106879);
        arg0.fee_rate = arg1;
    }

    public(friend) fun set_fee_recipient(arg0: &mut Listings, arg1: address) {
        arg0.fee_recipient = arg1;
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

    public(friend) fun set_warranty_price_recipient(arg0: &mut Listings, arg1: address) {
        arg0.warranty_price_recipient = arg1;
    }

    public fun update_listing(arg0: &mut Listings, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &0x2::tx_context::TxContext) {
        check_package_available(arg0);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut arg0.id, arg1);
        assert!(v0.seller_address == 0x2::tx_context::sender(arg6), 1);
        v0.price = arg2;
        v0.available_amount = arg3;
        v0.asset.name = arg4;
        v0.asset.image_url = arg5;
        let v1 = ListingUpdated{
            listing_id     : arg1,
            seller_address : 0x2::tx_context::sender(arg6),
            coin_type_name : v0.coin_type_name,
            price          : arg2,
            amount         : arg3,
            asset          : v0.asset,
        };
        0x2::event::emit<ListingUpdated>(v1);
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

