module 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::review {
    struct ReviewKey has copy, drop, store {
        escrow_id: address,
        reviewer: address,
    }

    struct ReviewRegistry has key {
        id: 0x2::object::UID,
        review_count: u64,
    }

    struct ReviewAnchor has key {
        id: 0x2::object::UID,
        order_ref: vector<u8>,
        escrow_id: address,
        reviewer: address,
        reviewer_role: u8,
        subject: address,
        rating: u8,
        review_hash: 0x1::string::String,
        created_at_ms: u64,
    }

    struct ReviewPosted has copy, drop {
        review_id: address,
        order_ref: vector<u8>,
        escrow_id: address,
        reviewer: address,
        reviewer_role: u8,
        subject: address,
        rating: u8,
        review_hash: 0x1::string::String,
        created_at_ms: u64,
    }

    struct ReviewRegistryInitialized has copy, drop {
        registry_id: address,
    }

    fun assert_hex_string(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        assert!(0x1::vector::length<u8>(v0) == 64 && is_lower_hex_ascii(v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_review_invalid_input());
    }

    fun assert_non_empty_with_max(arg0: &vector<u8>, arg1: u64) {
        let v0 = 0x1::vector::length<u8>(arg0);
        assert!(v0 > 0 && v0 <= arg1, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_review_invalid_input());
    }

    fun assert_valid_rating(arg0: u8) {
        assert!(arg0 >= 1 && arg0 <= 5, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_review_invalid_rating());
    }

    public fun has_reviewed(arg0: &ReviewRegistry, arg1: address, arg2: address) : bool {
        let v0 = ReviewKey{
            escrow_id : arg1,
            reviewer  : arg2,
        };
        0x2::dynamic_field::exists_<ReviewKey>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReviewRegistry{
            id           : 0x2::object::new(arg0),
            review_count : 0,
        };
        let v1 = 0x2::object::id<ReviewRegistry>(&v0);
        let v2 = ReviewRegistryInitialized{registry_id: 0x2::object::id_to_address(&v1)};
        0x2::event::emit<ReviewRegistryInitialized>(v2);
        0x2::transfer::share_object<ReviewRegistry>(v0);
    }

    fun is_lower_hex_ascii(arg0: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = *0x1::vector::borrow<u8>(arg0, v0);
            let v2 = v1 >= 48 && v1 <= 57;
            let v3 = v1 >= 97 && v1 <= 102;
            if (!v2 && !v3) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun max_rating() : u8 {
        5
    }

    public fun min_rating() : u8 {
        1
    }

    fun post_review_internal(arg0: &mut ReviewRegistry, arg1: vector<u8>, arg2: address, arg3: address, arg4: address, arg5: u8, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(v0 == arg3 || v0 == arg4, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_review_not_authorized());
        assert!(arg3 != arg4, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_review_invalid_input());
        assert!(arg3 != @0x0 && arg4 != @0x0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_review_invalid_input());
        assert_non_empty_with_max(&arg1, 128);
        assert_valid_rating(arg5);
        assert_hex_string(&arg6);
        let v1 = ReviewKey{
            escrow_id : arg2,
            reviewer  : v0,
        };
        assert!(!0x2::dynamic_field::exists_<ReviewKey>(&arg0.id, v1), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_review_already_exists());
        let (v2, v3) = if (v0 == arg3) {
            (0, arg4)
        } else {
            (1, arg3)
        };
        let v4 = ReviewKey{
            escrow_id : arg2,
            reviewer  : v0,
        };
        0x2::dynamic_field::add<ReviewKey, bool>(&mut arg0.id, v4, true);
        arg0.review_count = arg0.review_count + 1;
        let v5 = 0x2::clock::timestamp_ms(arg7);
        let v6 = ReviewAnchor{
            id            : 0x2::object::new(arg8),
            order_ref     : arg1,
            escrow_id     : arg2,
            reviewer      : v0,
            reviewer_role : v2,
            subject       : v3,
            rating        : arg5,
            review_hash   : arg6,
            created_at_ms : v5,
        };
        let v7 = 0x2::object::id<ReviewAnchor>(&v6);
        let v8 = ReviewPosted{
            review_id     : 0x2::object::id_to_address(&v7),
            order_ref     : v6.order_ref,
            escrow_id     : arg2,
            reviewer      : v0,
            reviewer_role : v2,
            subject       : v3,
            rating        : arg5,
            review_hash   : v6.review_hash,
            created_at_ms : v5,
        };
        0x2::event::emit<ReviewPosted>(v8);
        0x2::transfer::transfer<ReviewAnchor>(v6, v0);
    }

    public fun post_review_with_milestone_escrow<T0>(arg0: &mut ReviewRegistry, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::milestone_escrow::MilestoneEscrow<T0>, arg2: u8, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::milestone_escrow::review_is_terminal<T0>(arg1), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_review_invalid_input());
        post_review_internal(arg0, 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::milestone_escrow::review_order_ref<T0>(arg1), 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::milestone_escrow::escrow_id_for_review<T0>(arg1), 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::milestone_escrow::review_buyer<T0>(arg1), 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::milestone_escrow::review_seller<T0>(arg1), arg2, arg3, arg4, arg5);
    }

    public fun post_review_with_order_escrow<T0>(arg0: &mut ReviewRegistry, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::order_escrow::OrderEscrow<T0>, arg2: u8, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::order_escrow::review_is_terminal<T0>(arg1), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_review_invalid_input());
        post_review_internal(arg0, 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::order_escrow::review_order_ref<T0>(arg1), 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::order_escrow::escrow_id_for_review<T0>(arg1), 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::order_escrow::review_buyer<T0>(arg1), 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::order_escrow::review_seller<T0>(arg1), arg2, arg3, arg4, arg5);
    }

    public fun review_count(arg0: &ReviewRegistry) : u64 {
        arg0.review_count
    }

    public fun role_buyer() : u8 {
        0
    }

    public fun role_seller() : u8 {
        1
    }

    // decompiled from Move bytecode v7
}

