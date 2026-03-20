module 0xc9025cfcda1875dad37f8283f7fbd13d99ba57883d9737119402255a31b5598f::policy {
    struct VideoPolicy has store, key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        visibility: u8,
        published: bool,
        nonce: vector<u8>,
        ttl_days: u64,
        expires_at_ms: u64,
        title: vector<u8>,
        slug: vector<u8>,
    }

    struct Cap has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
    }

    fun cap_matches(arg0: &VideoPolicy, arg1: &Cap) : bool {
        arg1.policy_id == 0x2::object::id<VideoPolicy>(arg0)
    }

    fun check_policy(arg0: vector<u8>, arg1: &VideoPolicy, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) : bool {
        assert!(arg1.version == 1, 4);
        if (!matches_identity(arg1.owner, &arg1.nonce, &arg0)) {
            return false
        };
        if (0x2::clock::timestamp_ms(arg2) > arg1.expires_at_ms) {
            return false
        };
        if (arg1.visibility == 2 && arg1.published) {
            return true
        };
        if (arg1.visibility == 0 || arg1.visibility == 1) {
            return 0x2::tx_context::sender(arg3) == arg1.owner
        };
        0x2::tx_context::sender(arg3) == arg1.owner
    }

    public fun create_video_policy_entry(arg0: u8, arg1: bool, arg2: vector<u8>, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3 == 0) {
            1
        } else {
            arg3
        };
        let v1 = VideoPolicy{
            id            : 0x2::object::new(arg7),
            version       : 1,
            owner         : 0x2::tx_context::sender(arg7),
            visibility    : arg0,
            published     : arg1,
            nonce         : arg2,
            ttl_days      : v0,
            expires_at_ms : 0x2::clock::timestamp_ms(arg6) + v0 * 86400000,
            title         : arg4,
            slug          : arg5,
        };
        let v2 = Cap{
            id        : 0x2::object::new(arg7),
            policy_id : 0x2::object::id<VideoPolicy>(&v1),
        };
        0x2::transfer::share_object<VideoPolicy>(v1);
        0x2::transfer::public_transfer<Cap>(v2, 0x2::tx_context::sender(arg7));
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

    entry fun seal_approve(arg0: vector<u8>, arg1: &VideoPolicy, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(check_policy(arg0, arg1, arg2, arg3), 1);
    }

    public fun unpublish(arg0: &mut VideoPolicy, arg1: &Cap) {
        assert!(cap_matches(arg0, arg1), 2);
        arg0.published = false;
    }

    // decompiled from Move bytecode v6
}

