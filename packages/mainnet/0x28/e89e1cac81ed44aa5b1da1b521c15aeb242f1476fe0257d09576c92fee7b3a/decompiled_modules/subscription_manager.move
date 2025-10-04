module 0x28e89e1cac81ed44aa5b1da1b521c15aeb242f1476fe0257d09576c92fee7b3a::subscription_manager {
    struct SUBSCRIPTION_MANAGER has drop {
        dummy_field: bool,
    }

    struct Subscription has key {
        id: 0x2::object::UID,
        treasury: address,
        tiers: vector<Tier>,
        frozen: bool,
    }

    struct Tier has copy, drop, store {
        price: u64,
        days: u64,
        discount_nft_types: vector<0x1::ascii::String>,
        discount: u64,
    }

    struct Receipt has store, key {
        id: 0x2::object::UID,
        sub_id: 0x2::object::ID,
        tier_index: u8,
        expiry: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        sub_id: 0x2::object::ID,
    }

    public fun change_tier(arg0: &Subscription, arg1: &Receipt, arg2: u8, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.sub_id == 0x2::object::id<Subscription>(arg0), 3);
        let v0 = 0x1::vector::borrow<Tier>(&arg0.tiers, (arg2 as u64));
        let v1 = v0.price;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1, arg5), arg0.treasury);
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = if (arg1.expiry < v2) {
            v2
        } else {
            arg1.expiry
        };
        let v4 = Receipt{
            id          : 0x2::object::new(arg5),
            sub_id      : arg1.sub_id,
            tier_index  : arg2,
            expiry      : v3 + v0.days * 86400000,
            name        : arg1.name,
            description : arg1.description,
            image_url   : arg1.image_url,
        };
        0x2::transfer::public_transfer<Receipt>(v4, 0x2::tx_context::sender(arg5));
    }

    public fun change_tier_with_discount<T0: store + key>(arg0: &Subscription, arg1: &Receipt, arg2: u8, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &T0, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.sub_id == 0x2::object::id<Subscription>(arg0), 3);
        let v0 = 0x1::vector::borrow<Tier>(&arg0.tiers, (arg2 as u64));
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::ascii::String>(&v0.discount_nft_types)) {
            if (*0x1::vector::borrow<0x1::ascii::String>(&v0.discount_nft_types, v2) == 0x1::type_name::into_string(0x1::type_name::get<T0>())) {
                v1 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v1, 1);
        let v3 = v0.price - v0.discount;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v3, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v3, arg6), arg0.treasury);
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v4 = 0x2::clock::timestamp_ms(arg5);
        let v5 = if (arg1.expiry < v4) {
            v4
        } else {
            arg1.expiry
        };
        let v6 = Receipt{
            id          : 0x2::object::new(arg6),
            sub_id      : arg1.sub_id,
            tier_index  : arg2,
            expiry      : v5 + v0.days * 86400000,
            name        : arg1.name,
            description : arg1.description,
            image_url   : arg1.image_url,
        };
        0x2::transfer::public_transfer<Receipt>(v6, 0x2::tx_context::sender(arg6));
    }

    public fun create_subscription(arg0: address, arg1: vector<u64>, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<vector<0x1::ascii::String>>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 2);
        assert!(v0 == 0x1::vector::length<vector<0x1::ascii::String>>(&arg4), 2);
        let v1 = 0x1::vector::empty<Tier>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = Tier{
                price              : *0x1::vector::borrow<u64>(&arg1, v2),
                days               : *0x1::vector::borrow<u64>(&arg2, v2),
                discount_nft_types : *0x1::vector::borrow<vector<0x1::ascii::String>>(&arg4, v2),
                discount           : *0x1::vector::borrow<u64>(&arg3, v2),
            };
            0x1::vector::push_back<Tier>(&mut v1, v3);
            v2 = v2 + 1;
        };
        let v4 = Subscription{
            id       : 0x2::object::new(arg5),
            treasury : arg0,
            tiers    : v1,
            frozen   : false,
        };
        0x2::transfer::share_object<Subscription>(v4);
        let v5 = AdminCap{
            id     : 0x2::object::new(arg5),
            sub_id : 0x2::object::id<Subscription>(&v4),
        };
        0x2::transfer::public_transfer<AdminCap>(v5, 0x2::tx_context::sender(arg5));
    }

    public fun freeze_subscription(arg0: &mut Subscription, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.sub_id == 0x2::object::id<Subscription>(arg0), 5);
        arg0.frozen = true;
    }

    public fun get_receipt(arg0: &Receipt) : (0x2::object::ID, u8, u64) {
        (arg0.sub_id, arg0.tier_index, arg0.expiry)
    }

    public fun get_subscription(arg0: &Subscription) : (address, &vector<Tier>, bool) {
        (arg0.treasury, &arg0.tiers, arg0.frozen)
    }

    public fun get_tier(arg0: &Subscription, arg1: u8) : &Tier {
        0x1::vector::borrow<Tier>(&arg0.tiers, (arg1 as u64))
    }

    fun init(arg0: SUBSCRIPTION_MANAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://seer.theorder.site"));
        let v4 = 0x2::package::claim<SUBSCRIPTION_MANAGER>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Receipt>(&v4, v0, v2, arg1);
        0x2::display::update_version<Receipt>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Receipt>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun is_frozen(arg0: &Subscription) : bool {
        arg0.frozen
    }

    public fun is_receipt_active(arg0: &Receipt, arg1: &0x2::clock::Clock) : bool {
        arg0.expiry > 0x2::clock::timestamp_ms(arg1)
    }

    public fun renew(arg0: &Subscription, arg1: &Receipt, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.sub_id == 0x2::object::id<Subscription>(arg0), 3);
        let v0 = 0x1::vector::borrow<Tier>(&arg0.tiers, (arg1.tier_index as u64));
        let v1 = v0.price;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1, arg4), arg0.treasury);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = if (arg1.expiry < v2) {
            v2
        } else {
            arg1.expiry
        };
        let v4 = Receipt{
            id          : 0x2::object::new(arg4),
            sub_id      : arg1.sub_id,
            tier_index  : arg1.tier_index,
            expiry      : v3 + v0.days * 86400000,
            name        : arg1.name,
            description : arg1.description,
            image_url   : arg1.image_url,
        };
        0x2::transfer::public_transfer<Receipt>(v4, 0x2::tx_context::sender(arg4));
    }

    public fun renew_with_discount<T0: store + key>(arg0: &Subscription, arg1: &Receipt, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &T0, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.sub_id == 0x2::object::id<Subscription>(arg0), 3);
        let v0 = 0x1::vector::borrow<Tier>(&arg0.tiers, (arg1.tier_index as u64));
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::ascii::String>(&v0.discount_nft_types)) {
            if (*0x1::vector::borrow<0x1::ascii::String>(&v0.discount_nft_types, v2) == 0x1::type_name::into_string(0x1::type_name::get<T0>())) {
                v1 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v1, 1);
        let v3 = v0.price - v0.discount;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v3, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v3, arg5), arg0.treasury);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v4 = 0x2::clock::timestamp_ms(arg4);
        let v5 = if (arg1.expiry < v4) {
            v4
        } else {
            arg1.expiry
        };
        let v6 = Receipt{
            id          : 0x2::object::new(arg5),
            sub_id      : arg1.sub_id,
            tier_index  : arg1.tier_index,
            expiry      : v5 + v0.days * 86400000,
            name        : arg1.name,
            description : arg1.description,
            image_url   : arg1.image_url,
        };
        0x2::transfer::public_transfer<Receipt>(v6, 0x2::tx_context::sender(arg5));
    }

    public fun subscribe(arg0: &Subscription, arg1: u8, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.frozen, 4);
        let v0 = 0x1::vector::borrow<Tier>(&arg0.tiers, (arg1 as u64));
        let v1 = v0.price;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v1, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1, arg4), arg0.treasury);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg4));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v2 = Receipt{
            id          : 0x2::object::new(arg4),
            sub_id      : 0x2::object::id<Subscription>(arg0),
            tier_index  : arg1,
            expiry      : 0x2::clock::timestamp_ms(arg3) + v0.days * 86400000,
            name        : 0x1::string::utf8(b"Seer Membership"),
            description : 0x1::string::utf8(b"This is your membership NFT for Seer. Metadata indicates the expiration of this asset"),
            image_url   : 0x1::string::utf8(b"https://walrus.tusky.io/LwaWZXoNmKFWCGZxKjjD7lO3TnCXKLURiDodHmKb24k"),
        };
        0x2::transfer::public_transfer<Receipt>(v2, 0x2::tx_context::sender(arg4));
    }

    public fun subscribe_with_discount<T0: store + key>(arg0: &Subscription, arg1: u8, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &T0, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.frozen, 4);
        let v0 = 0x1::vector::borrow<Tier>(&arg0.tiers, (arg1 as u64));
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::ascii::String>(&v0.discount_nft_types)) {
            if (*0x1::vector::borrow<0x1::ascii::String>(&v0.discount_nft_types, v2) == 0x1::type_name::into_string(0x1::type_name::get<T0>())) {
                v1 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v1, 1);
        let v3 = v0.price - v0.discount;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v3, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v3, arg8), arg0.treasury);
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg8));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v4 = Receipt{
            id          : 0x2::object::new(arg8),
            sub_id      : 0x2::object::id<Subscription>(arg0),
            tier_index  : arg1,
            expiry      : 0x2::clock::timestamp_ms(arg7) + v0.days * 86400000,
            name        : arg4,
            description : arg5,
            image_url   : arg6,
        };
        0x2::transfer::public_transfer<Receipt>(v4, 0x2::tx_context::sender(arg8));
    }

    public fun unfreeze_subscription(arg0: &mut Subscription, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.sub_id == 0x2::object::id<Subscription>(arg0), 5);
        arg0.frozen = false;
    }

    public fun update_single_tier(arg0: &mut Subscription, arg1: &AdminCap, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: vector<0x1::ascii::String>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.sub_id == 0x2::object::id<Subscription>(arg0), 5);
        assert!(!arg0.frozen, 4);
        assert!((arg2 as u64) < 0x1::vector::length<Tier>(&arg0.tiers), 6);
        let v0 = Tier{
            price              : arg3,
            days               : arg4,
            discount_nft_types : arg6,
            discount           : arg5,
        };
        *0x1::vector::borrow_mut<Tier>(&mut arg0.tiers, (arg2 as u64)) = v0;
    }

    public fun update_tiers(arg0: &mut Subscription, arg1: &AdminCap, arg2: vector<u64>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<vector<0x1::ascii::String>>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.sub_id == 0x2::object::id<Subscription>(arg0), 5);
        assert!(!arg0.frozen, 4);
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 2);
        assert!(v0 == 0x1::vector::length<u64>(&arg4), 2);
        assert!(v0 == 0x1::vector::length<vector<0x1::ascii::String>>(&arg5), 2);
        let v1 = 0x1::vector::empty<Tier>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = Tier{
                price              : *0x1::vector::borrow<u64>(&arg2, v2),
                days               : *0x1::vector::borrow<u64>(&arg3, v2),
                discount_nft_types : *0x1::vector::borrow<vector<0x1::ascii::String>>(&arg5, v2),
                discount           : *0x1::vector::borrow<u64>(&arg4, v2),
            };
            0x1::vector::push_back<Tier>(&mut v1, v3);
            v2 = v2 + 1;
        };
        arg0.tiers = v1;
    }

    // decompiled from Move bytecode v6
}

