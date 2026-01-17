module 0xbcd80d7fd318da71038bbc9d9b055e200b43e4a79f67824d6a42cadc9345eabf::marketplace {
    struct MARKETPLACE has drop {
        dummy_field: bool,
    }

    struct ListingCreated has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        base_price: u64,
        price_slope: u64,
        walrus_blob_id: 0x1::string::String,
        mime_type: 0x1::string::String,
    }

    struct AccessRented has copy, drop {
        listing_id: 0x2::object::ID,
        buyer: address,
        price_paid: u64,
        hours: u64,
        expiry_ms: u64,
        walrus_blob_id: 0x1::string::String,
    }

    struct BalanceWithdrawn has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        amount: u64,
    }

    struct AccessExpired has copy, drop {
        listing_id: 0x2::object::ID,
        access_pass_id: 0x2::object::ID,
        original_buyer: address,
        caller: address,
        expiry_ms: u64,
    }

    struct ListingStatusChanged has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        is_active: bool,
    }

    struct ListingPricingUpdated has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        old_base_price: u64,
        new_base_price: u64,
        old_price_slope: u64,
        new_price_slope: u64,
    }

    struct ActiveRentalsDecayed has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        requested_decay: u64,
        actual_decay: u64,
        new_active_rentals: u64,
    }

    struct ListingOwnershipTransferred has copy, drop {
        listing_id: 0x2::object::ID,
        old_seller: address,
        new_seller: address,
        balance_withdrawn: u64,
    }

    struct ListingContentUpdated has copy, drop {
        listing_id: 0x2::object::ID,
        seller: address,
        old_blob_id: 0x1::string::String,
        new_blob_id: 0x1::string::String,
        old_lit_hash: 0x1::string::String,
        new_lit_hash: 0x1::string::String,
    }

    struct Listing has key {
        id: 0x2::object::UID,
        seller: address,
        walrus_blob_id: 0x1::string::String,
        lit_data_hash: 0x1::string::String,
        base_price: u64,
        price_slope: u64,
        active_rentals: u64,
        mime_type: 0x1::string::String,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        is_active: bool,
        last_decay_timestamp: u64,
        decayed_this_period: u64,
    }

    struct AccessPass has store, key {
        id: 0x2::object::UID,
        listing_id: 0x2::object::ID,
        expiry_ms: u64,
        original_buyer: address,
    }

    public entry fun withdraw_all(arg0: &mut Listing, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        withdraw_balance(arg0, v0, arg1);
    }

    public entry fun batch_expire_access(arg0: &mut Listing, arg1: vector<AccessPass>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<AccessPass>(&arg1);
        assert!(v0 <= 50, 17);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::pop_back<AccessPass>(&mut arg1);
            assert!(v3.listing_id == v1, 5);
            assert!(0x2::clock::timestamp_ms(arg2) > v3.expiry_ms, 6);
            let v4 = AccessExpired{
                listing_id     : v1,
                access_pass_id : 0x2::object::uid_to_inner(&v3.id),
                original_buyer : v3.original_buyer,
                caller         : 0x2::tx_context::sender(arg3),
                expiry_ms      : v3.expiry_ms,
            };
            0x2::event::emit<AccessExpired>(v4);
            if (arg0.active_rentals > 0) {
                arg0.active_rentals = arg0.active_rentals - 1;
            };
            let AccessPass {
                id             : v5,
                listing_id     : _,
                expiry_ms      : _,
                original_buyer : _,
            } = v3;
            0x2::object::delete(v5);
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<AccessPass>(arg1);
    }

    public entry fun create_listing(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg0) > 0, 10);
        assert!(0x1::string::length(&arg1) > 0, 14);
        assert!(0x1::string::length(&arg4) > 0, 18);
        assert!(arg2 >= 1000, 8);
        assert!(arg3 <= 114155251141552, 9);
        let v0 = Listing{
            id                   : 0x2::object::new(arg5),
            seller               : 0x2::tx_context::sender(arg5),
            walrus_blob_id       : arg0,
            lit_data_hash        : arg1,
            base_price           : arg2,
            price_slope          : arg3,
            active_rentals       : 0,
            mime_type            : arg4,
            balance              : 0x2::balance::zero<0x2::sui::SUI>(),
            is_active            : true,
            last_decay_timestamp : 0,
            decayed_this_period  : 0,
        };
        let v1 = ListingCreated{
            listing_id     : 0x2::object::uid_to_inner(&v0.id),
            seller         : 0x2::tx_context::sender(arg5),
            base_price     : arg2,
            price_slope    : arg3,
            walrus_blob_id : v0.walrus_blob_id,
            mime_type      : v0.mime_type,
        };
        0x2::event::emit<ListingCreated>(v1);
        0x2::transfer::share_object<Listing>(v0);
    }

    public entry fun decay_active_rentals(arg0: &mut Listing, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.seller, 11);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (v0 >= arg0.last_decay_timestamp + 86400000) {
            arg0.decayed_this_period = 0;
            arg0.last_decay_timestamp = v0;
        };
        let v1 = if (100 > arg0.decayed_this_period) {
            100 - arg0.decayed_this_period
        } else {
            0
        };
        assert!(arg1 <= v1, 20);
        let v2 = if (arg0.active_rentals >= arg1) {
            arg0.active_rentals = arg0.active_rentals - arg1;
            arg1
        } else {
            arg0.active_rentals = 0;
            arg0.active_rentals
        };
        arg0.decayed_this_period = arg0.decayed_this_period + v2;
        let v3 = ActiveRentalsDecayed{
            listing_id         : 0x2::object::uid_to_inner(&arg0.id),
            seller             : arg0.seller,
            requested_decay    : arg1,
            actual_decay       : v2,
            new_active_rentals : arg0.active_rentals,
        };
        0x2::event::emit<ActiveRentalsDecayed>(v3);
    }

    public entry fun expire_access(arg0: &mut Listing, arg1: AccessPass, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(arg1.listing_id == v0, 5);
        assert!(0x2::clock::timestamp_ms(arg2) > arg1.expiry_ms, 6);
        let v1 = AccessExpired{
            listing_id     : v0,
            access_pass_id : 0x2::object::uid_to_inner(&arg1.id),
            original_buyer : arg1.original_buyer,
            caller         : 0x2::tx_context::sender(arg3),
            expiry_ms      : arg1.expiry_ms,
        };
        0x2::event::emit<AccessExpired>(v1);
        if (arg0.active_rentals > 0) {
            arg0.active_rentals = arg0.active_rentals - 1;
        };
        let AccessPass {
            id             : v2,
            listing_id     : _,
            expiry_ms      : _,
            original_buyer : _,
        } = arg1;
        0x2::object::delete(v2);
    }

    public fun get_access_pass_listing_id(arg0: &AccessPass) : 0x2::object::ID {
        arg0.listing_id
    }

    public fun get_active_rentals(arg0: &Listing) : u64 {
        arg0.active_rentals
    }

    public fun get_balance(arg0: &Listing) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_base_price(arg0: &Listing) : u64 {
        arg0.base_price
    }

    public fun get_blob_id(arg0: &Listing) : 0x1::string::String {
        arg0.walrus_blob_id
    }

    public fun get_current_price(arg0: &Listing) : u64 {
        let v0 = arg0.active_rentals * arg0.price_slope;
        if (arg0.price_slope > 0 && v0 / arg0.price_slope != arg0.active_rentals) {
            return 1000000000000000
        };
        let v1 = arg0.base_price + v0;
        if (v1 < arg0.base_price) {
            return 1000000000000000
        };
        if (v1 > 1000000000000000) {
            1000000000000000
        } else {
            v1
        }
    }

    public fun get_decay_cooldown_ms() : u64 {
        86400000
    }

    public fun get_decayed_this_period(arg0: &Listing) : u64 {
        arg0.decayed_this_period
    }

    public fun get_expiry_ms(arg0: &AccessPass) : u64 {
        arg0.expiry_ms
    }

    public fun get_last_decay_timestamp(arg0: &Listing) : u64 {
        arg0.last_decay_timestamp
    }

    public fun get_lit_data_hash(arg0: &Listing) : 0x1::string::String {
        arg0.lit_data_hash
    }

    public fun get_max_active_rentals() : u64 {
        1000000
    }

    public fun get_max_batch_size() : u64 {
        50
    }

    public fun get_max_decay_per_period() : u64 {
        100
    }

    public fun get_max_price() : u64 {
        1000000000000000
    }

    public fun get_max_rental_hours() : u64 {
        8760
    }

    public fun get_max_slope() : u64 {
        114155251141552
    }

    public fun get_mime_type(arg0: &Listing) : 0x1::string::String {
        arg0.mime_type
    }

    public fun get_min_base_price() : u64 {
        1000
    }

    public fun get_min_withdrawal() : u64 {
        1000000
    }

    public fun get_original_buyer(arg0: &AccessPass) : address {
        arg0.original_buyer
    }

    public fun get_price_slope(arg0: &Listing) : u64 {
        arg0.price_slope
    }

    public fun get_seller(arg0: &Listing) : address {
        arg0.seller
    }

    fun init(arg0: MARKETPLACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MARKETPLACE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"GhostKey Access Pass"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Time-limited access pass for encrypted content on GhostKey marketplace. Expires at {expiry_ms} ms."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://assets.ghostkey.phunhuanbuilder.com/nft/access-pass.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://ghostkey.phunhuanbuilder.com"));
        let v5 = 0x2::display::new_with_fields<AccessPass>(&v0, v1, v3, arg1);
        0x2::display::update_version<AccessPass>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<AccessPass>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun is_listing_active(arg0: &Listing) : bool {
        arg0.is_active
    }

    public entry fun pause_listing(arg0: &mut Listing, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 11);
        arg0.is_active = false;
        let v0 = ListingStatusChanged{
            listing_id : 0x2::object::uid_to_inner(&arg0.id),
            seller     : arg0.seller,
            is_active  : false,
        };
        0x2::event::emit<ListingStatusChanged>(v0);
    }

    public entry fun rent_access(arg0: &mut Listing, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 3);
        assert!(arg2 > 0, 2);
        assert!(arg2 <= 8760, 2);
        let v0 = arg0.active_rentals * arg0.price_slope;
        if (arg0.price_slope > 0) {
            assert!(v0 / arg0.price_slope == arg0.active_rentals, 7);
        };
        let v1 = arg0.base_price + v0;
        assert!(v1 >= arg0.base_price, 7);
        assert!(v1 <= 1000000000000000, 7);
        let v2 = v1 * arg2;
        assert!(v2 / arg2 == v1, 7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v2, 1);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v2));
        if (0x2::balance::value<0x2::sui::SUI>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg4), 0x2::tx_context::sender(arg4));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
        };
        assert!(arg0.active_rentals < 1000000, 15);
        arg0.active_rentals = arg0.active_rentals + 1;
        let v4 = 0x2::clock::timestamp_ms(arg3);
        let v5 = v4 + arg2 * 3600 * 1000;
        assert!(v5 > v4, 2);
        let v6 = 0x2::tx_context::sender(arg4);
        let v7 = AccessRented{
            listing_id     : 0x2::object::uid_to_inner(&arg0.id),
            buyer          : v6,
            price_paid     : v2,
            hours          : arg2,
            expiry_ms      : v5,
            walrus_blob_id : arg0.walrus_blob_id,
        };
        0x2::event::emit<AccessRented>(v7);
        let v8 = AccessPass{
            id             : 0x2::object::new(arg4),
            listing_id     : 0x2::object::uid_to_inner(&arg0.id),
            expiry_ms      : v5,
            original_buyer : v6,
        };
        0x2::transfer::public_transfer<AccessPass>(v8, v6);
    }

    public entry fun rent_access_with_max_price(arg0: &mut Listing, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(get_current_price(arg0) <= arg3, 12);
        rent_access(arg0, arg1, arg2, arg4, arg5);
    }

    public entry fun resume_listing(arg0: &mut Listing, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 11);
        arg0.is_active = true;
        let v0 = ListingStatusChanged{
            listing_id : 0x2::object::uid_to_inner(&arg0.id),
            seller     : arg0.seller,
            is_active  : true,
        };
        0x2::event::emit<ListingStatusChanged>(v0);
    }

    public entry fun transfer_listing_ownership(arg0: &mut Listing, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.seller, 11);
        assert!(arg1 != @0x0, 16);
        assert!(arg1 != arg0.seller, 16);
        let v0 = arg0.seller;
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.balance), arg2), v0);
        };
        arg0.seller = arg1;
        let v2 = ListingOwnershipTransferred{
            listing_id        : 0x2::object::uid_to_inner(&arg0.id),
            old_seller        : v0,
            new_seller        : arg1,
            balance_withdrawn : v1,
        };
        0x2::event::emit<ListingOwnershipTransferred>(v2);
    }

    public entry fun update_content_references(arg0: &mut Listing, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.seller, 11);
        assert!(!arg0.is_active, 21);
        assert!(0x1::string::length(&arg1) > 0, 10);
        assert!(0x1::string::length(&arg2) > 0, 14);
        arg0.walrus_blob_id = arg1;
        arg0.lit_data_hash = arg2;
        let v0 = ListingContentUpdated{
            listing_id   : 0x2::object::uid_to_inner(&arg0.id),
            seller       : arg0.seller,
            old_blob_id  : arg0.walrus_blob_id,
            new_blob_id  : arg0.walrus_blob_id,
            old_lit_hash : arg0.lit_data_hash,
            new_lit_hash : arg0.lit_data_hash,
        };
        0x2::event::emit<ListingContentUpdated>(v0);
    }

    public entry fun update_pricing(arg0: &mut Listing, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.seller, 11);
        assert!(arg1 >= 1000, 8);
        assert!(arg2 <= 114155251141552, 9);
        arg0.base_price = arg1;
        arg0.price_slope = arg2;
        let v0 = ListingPricingUpdated{
            listing_id      : 0x2::object::uid_to_inner(&arg0.id),
            seller          : arg0.seller,
            old_base_price  : arg0.base_price,
            new_base_price  : arg1,
            old_price_slope : arg0.price_slope,
            new_price_slope : arg2,
        };
        0x2::event::emit<ListingPricingUpdated>(v0);
    }

    public entry fun withdraw_balance(arg0: &mut Listing, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.seller, 4);
        assert!(arg1 >= 1000000, 13);
        let v0 = BalanceWithdrawn{
            listing_id : 0x2::object::uid_to_inner(&arg0.id),
            seller     : arg0.seller,
            amount     : arg1,
        };
        0x2::event::emit<BalanceWithdrawn>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2), arg0.seller);
    }

    // decompiled from Move bytecode v6
}

