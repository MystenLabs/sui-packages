module 0xdfc6f9761c8bffa029587e2924c9a9d4cdeb1eb89b0965bfc88330ec2a795397::policy {
    struct VideoPolicy has store, key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        visibility: u8,
        published: bool,
        nonce: vector<u8>,
        ttl_days: u64,
        expires_at_ms: u64,
        purchase_price_mist: u64,
        rental_price_mist: u64,
        rental_duration_days: u64,
        title: vector<u8>,
        slug: vector<u8>,
    }

    struct Cap has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
    }

    struct MovieLicense has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
        purchased_at_ms: u64,
    }

    struct RentalPass has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
        rented_at_ms: u64,
        expires_at_ms: u64,
    }

    fun base_policy_allows(arg0: vector<u8>, arg1: &VideoPolicy, arg2: &0x2::clock::Clock) : bool {
        assert!(arg1.version == 2, 4);
        if (0x2::clock::timestamp_ms(arg2) > arg1.expires_at_ms) {
            return false
        };
        if (!matches_identity(arg1.owner, &arg1.nonce, &arg0)) {
            return false
        };
        true
    }

    public fun buy_license_entry(arg0: &VideoPolicy, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.purchase_price_mist > 0, 5);
        assert!(arg0.published, 8);
        assert!(policy_active(arg0, arg2), 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.purchase_price_mist, 7);
        let v0 = MovieLicense{
            id              : 0x2::object::new(arg3),
            policy_id       : 0x2::object::id<VideoPolicy>(arg0),
            purchased_at_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.owner);
        0x2::transfer::public_transfer<MovieLicense>(v0, 0x2::tx_context::sender(arg3));
    }

    fun cap_matches(arg0: &VideoPolicy, arg1: &Cap) : bool {
        arg1.policy_id == 0x2::object::id<VideoPolicy>(arg0)
    }

    public fun create_video_policy_entry(arg0: u8, arg1: bool, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3 == 0) {
            1
        } else {
            arg3
        };
        let v1 = if (arg5 == 0) {
            0
        } else if (arg6 == 0) {
            1
        } else {
            arg6
        };
        let v2 = VideoPolicy{
            id                   : 0x2::object::new(arg10),
            version              : 2,
            owner                : 0x2::tx_context::sender(arg10),
            visibility           : arg0,
            published            : arg1,
            nonce                : arg2,
            ttl_days             : v0,
            expires_at_ms        : 0x2::clock::timestamp_ms(arg9) + v0 * 86400000,
            purchase_price_mist  : arg4,
            rental_price_mist    : arg5,
            rental_duration_days : v1,
            title                : arg7,
            slug                 : arg8,
        };
        let v3 = Cap{
            id        : 0x2::object::new(arg10),
            policy_id : 0x2::object::id<VideoPolicy>(&v2),
        };
        0x2::transfer::share_object<VideoPolicy>(v2);
        0x2::transfer::public_transfer<Cap>(v3, 0x2::tx_context::sender(arg10));
    }

    fun entitled_access(arg0: vector<u8>, arg1: &VideoPolicy, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : bool {
        if (!base_policy_allows(arg0, arg1, arg2)) {
            return false
        };
        if (0x2::tx_context::sender(arg3) == arg1.owner) {
            return true
        };
        arg1.published
    }

    fun matches_identity(arg0: address, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        let v0 = 0x2::address::to_bytes(arg0);
        if (0x1::vector::length<u8>(arg2) != 0x1::vector::length<u8>(&v0) + 0x1::vector::length<u8>(arg1)) {
            return false
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&v0)) {
            if (*0x1::vector::borrow<u8>(&v0, v1) != *0x1::vector::borrow<u8>(arg2, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(arg1)) {
            if (*0x1::vector::borrow<u8>(arg1, v2) != *0x1::vector::borrow<u8>(arg2, 0x1::vector::length<u8>(&v0) + v2)) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    fun policy_active(arg0: &VideoPolicy, arg1: &0x2::clock::Clock) : bool {
        assert!(arg0.version == 2, 4);
        0x2::clock::timestamp_ms(arg1) <= arg0.expires_at_ms
    }

    fun public_open_access(arg0: vector<u8>, arg1: &VideoPolicy, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : bool {
        if (!base_policy_allows(arg0, arg1, arg2)) {
            return false
        };
        let v0 = if (arg1.visibility == 2) {
            if (arg1.published) {
                if (arg1.purchase_price_mist == 0) {
                    arg1.rental_price_mist == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            return true
        };
        if (arg1.visibility == 0 || arg1.visibility == 1) {
            return 0x2::tx_context::sender(arg3) == arg1.owner
        };
        0x2::tx_context::sender(arg3) == arg1.owner
    }

    public fun publish(arg0: &mut VideoPolicy, arg1: &Cap, arg2: &0x2::clock::Clock) {
        assert!(cap_matches(arg0, arg1), 2);
        arg0.published = true;
        if (arg0.expires_at_ms < 0x2::clock::timestamp_ms(arg2)) {
            arg0.expires_at_ms = 0x2::clock::timestamp_ms(arg2) + arg0.ttl_days * 86400000;
        };
    }

    public fun renew(arg0: &mut VideoPolicy, arg1: &Cap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(cap_matches(arg0, arg1), 2);
        let v0 = if (arg2 == 0) {
            1
        } else {
            arg2
        };
        arg0.ttl_days = v0;
        arg0.expires_at_ms = 0x2::clock::timestamp_ms(arg3) + v0 * 86400000;
    }

    public fun rent_video_entry(arg0: &VideoPolicy, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.rental_price_mist > 0, 6);
        assert!(arg0.published, 8);
        assert!(policy_active(arg0, arg2), 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.rental_price_mist, 7);
        let v0 = if (arg0.rental_duration_days == 0) {
            1
        } else {
            arg0.rental_duration_days
        };
        let v1 = RentalPass{
            id            : 0x2::object::new(arg3),
            policy_id     : 0x2::object::id<VideoPolicy>(arg0),
            rented_at_ms  : 0x2::clock::timestamp_ms(arg2),
            expires_at_ms : 0x2::clock::timestamp_ms(arg2) + v0 * 86400000,
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.owner);
        0x2::transfer::public_transfer<RentalPass>(v1, 0x2::tx_context::sender(arg3));
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &VideoPolicy, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(public_open_access(arg0, arg1, arg2, arg3), 1);
    }

    entry fun seal_approve_with_kiosk_license(arg0: vector<u8>, arg1: &VideoPolicy, arg2: &0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::borrow<MovieLicense>(arg2, arg3, arg4);
        assert!(entitled_access(arg0, arg1, arg5, arg6), 1);
        assert!(valid_license(v0, arg1), 9);
    }

    entry fun seal_approve_with_kiosk_rental(arg0: vector<u8>, arg1: &VideoPolicy, arg2: &0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::borrow<RentalPass>(arg2, arg3, arg4);
        assert!(entitled_access(arg0, arg1, arg5, arg6), 1);
        assert!(valid_rental(v0, arg1, arg5), 9);
    }

    entry fun seal_approve_with_license(arg0: vector<u8>, arg1: &VideoPolicy, arg2: &MovieLicense, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(entitled_access(arg0, arg1, arg3, arg4), 1);
        assert!(valid_license(arg2, arg1), 9);
    }

    entry fun seal_approve_with_rental(arg0: vector<u8>, arg1: &VideoPolicy, arg2: &RentalPass, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(entitled_access(arg0, arg1, arg3, arg4), 1);
        assert!(valid_rental(arg2, arg1, arg3), 9);
    }

    public fun unpublish(arg0: &mut VideoPolicy, arg1: &Cap) {
        assert!(cap_matches(arg0, arg1), 2);
        arg0.published = false;
    }

    fun valid_license(arg0: &MovieLicense, arg1: &VideoPolicy) : bool {
        arg0.policy_id == 0x2::object::id<VideoPolicy>(arg1)
    }

    fun valid_rental(arg0: &RentalPass, arg1: &VideoPolicy, arg2: &0x2::clock::Clock) : bool {
        arg0.policy_id == 0x2::object::id<VideoPolicy>(arg1) && arg0.expires_at_ms >= 0x2::clock::timestamp_ms(arg2)
    }

    // decompiled from Move bytecode v6
}

