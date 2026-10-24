module 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review {
    struct ReviewedV1 has copy, drop {
        job: 0x2::object::ID,
        rules_version: u64,
        status: 0x1::string::String,
        seller: address,
        by: address,
        stars: u8,
        text_hash: vector<u8>,
        at_ms: u64,
        replaced: bool,
    }

    entry fun review(arg0: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::Job, arg1: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::Guard, arg2: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::Registry, arg3: &mut 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond, arg4: u8, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::safety::assert_current_version(arg1);
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::buyer_side(arg0, v0), 0);
        assert!(0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::is_closed_with_delivery(arg0), 1);
        assert!(!0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::is_self_test(arg0), 2);
        assert!(arg4 >= 1 && arg4 <= 5, 3);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 4);
        assert!(0x2::object::id<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::Bond>(arg3) == 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::agent_registry::bond_of(arg2, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::seller(arg0)), 6);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::scored_for(arg0);
        let v3 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::ext_exists<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::ReviewKey>(arg0, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::key());
        if (v3) {
            let v4 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::funder(arg0);
            let v5 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::buyer_key(arg0);
            let v6 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::ext<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::ReviewKey, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::Review>(arg0, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::key());
            let v7 = if (v5 != v4) {
                if (v0 == v4) {
                    0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::by(v6) == v5
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v7, 5);
            let v8 = 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::stars(v6);
            0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::replace(0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::ext_mut<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::ReviewKey, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::Review>(arg0, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::key()), arg4, arg5, v0, v1);
            if (v2 != @0x0) {
                0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::replace_rating(arg3, v8, arg4);
                0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::correct_rating(arg3, 0x2::object::id<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::Job>(arg0), v2, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::budget(arg0), 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::closed_at_ms(arg0), 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::score_math::factor_tenths(v8), 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::score_math::factor_tenths(arg4));
            };
        } else {
            0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::ext_add<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::ReviewKey, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::Review>(arg0, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::key(), 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::new(arg4, arg5, v0, v1));
            if (v2 != @0x0) {
                0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::add_rating(arg3, arg4);
                0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::seller_bond::correct_rating(arg3, 0x2::object::id<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::Job>(arg0), v2, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::budget(arg0), 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::closed_at_ms(arg0), 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::score_math::unrated_tenths(), 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::score_math::factor_tenths(arg4));
            };
        };
        let v9 = ReviewedV1{
            job           : 0x2::object::id<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::Job>(arg0),
            rules_version : 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::rules_version(arg0),
            status        : 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::status(arg0),
            seller        : 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::seller(arg0),
            by            : v0,
            stars         : arg4,
            text_hash     : arg5,
            at_ms         : v1,
            replaced      : v3,
        };
        0x2::event::emit<ReviewedV1>(v9);
    }

    public fun stars_of(arg0: &0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::Job) : 0x1::option::Option<u8> {
        if (0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::ext_exists<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::ReviewKey>(arg0, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::key())) {
            0x1::option::some<u8>(0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::stars(0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::escrow::ext<0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::ReviewKey, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::Review>(arg0, 0xf0681f6f4c09e09a314a19dda76b8810b4b22b99cc3d567b4efabf7b79bc6ed6::review_state::key())))
        } else {
            0x1::option::none<u8>()
        }
    }

    // decompiled from Move bytecode v7
}

