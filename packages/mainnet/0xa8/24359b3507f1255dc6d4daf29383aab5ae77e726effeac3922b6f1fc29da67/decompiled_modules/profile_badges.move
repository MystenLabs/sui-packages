module 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile_badges {
    struct Badge has copy, drop, store {
        category: 0x1::string::String,
        tier: 0x1::string::String,
        display_name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::option::Option<0x1::string::String>,
        tier_number: u8,
        minted_at: u64,
    }

    struct BadgeCollection has store {
        badges: vector<Badge>,
        last_updated: u64,
    }

    struct BadgeMintedEvent has copy, drop {
        profile_id: 0x2::object::ID,
        profile_owner: address,
        category: 0x1::string::String,
        tier: 0x1::string::String,
        display_name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::option::Option<0x1::string::String>,
        tier_number: u8,
        timestamp: u64,
    }

    struct BadgeUpdatedEvent has copy, drop {
        profile_id: 0x2::object::ID,
        profile_owner: address,
        category: 0x1::string::String,
        old_tier: 0x1::string::String,
        new_tier: 0x1::string::String,
        old_tier_number: u8,
        new_tier_number: u8,
        display_name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::option::Option<0x1::string::String>,
        timestamp: u64,
    }

    fun construct_badge_attestation_message(arg0: 0x2::object::ID, arg1: &vector<u8>, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, b"badges");
        0x1::vector::append<u8>(&mut v0, b"||");
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x1::vector::append<u8>(&mut v0, b"||");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        v0
    }

    fun deserialize_badges(arg0: &vector<u8>, arg1: u64) : vector<Badge> {
        let v0 = 0x2::bcs::new(*arg0);
        let v1 = 0x1::vector::empty<Badge>();
        let v2 = 0;
        while (v2 < 0x2::bcs::peel_vec_length(&mut v0)) {
            let v3 = if (0x2::bcs::peel_bool(&mut v0)) {
                0x1::option::some<0x1::string::String>(0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)))
            } else {
                0x1::option::none<0x1::string::String>()
            };
            let v4 = Badge{
                category     : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
                tier         : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
                display_name : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
                description  : 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)),
                image_url    : v3,
                tier_number  : 0x2::bcs::peel_u8(&mut v0),
                minted_at    : arg1,
            };
            0x1::vector::push_back<Badge>(&mut v1, v4);
            v2 = v2 + 1;
        };
        v1
    }

    fun find_badge_by_category(arg0: &BadgeCollection, arg1: &0x1::string::String) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Badge>(&arg0.badges)) {
            if (0x1::vector::borrow<Badge>(&arg0.badges, v0).category == *arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun get_badges(arg0: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile) : vector<Badge> {
        let v0 = 0x1::string::utf8(b"badge_collection");
        if (!0x2::dynamic_field::exists_<0x1::string::String>(0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::uid(arg0), v0)) {
            return 0x1::vector::empty<Badge>()
        };
        0x2::dynamic_field::borrow<0x1::string::String, BadgeCollection>(0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::uid(arg0), v0).badges
    }

    public fun has_badge_category(arg0: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: 0x1::string::String) : bool {
        let v0 = get_badges(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<Badge>(&v0)) {
            if (0x1::vector::borrow<Badge>(&v0, v1).category == arg1) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun mint_badges(arg0: &mut 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::oracle_utils::OracleConfig, arg5: &0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::Config, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg7) == 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::owner(arg0), 2);
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::social_layer_config::assert_interacting_with_most_up_to_date_package(arg5);
        let v0 = 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::oracle_utils::get_oracle_public_key(arg4);
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::oracle_utils::validate_oracle_public_key(&v0);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg3 <= v1 + 5000, 13906834651084750849);
        assert!(v1 - arg3 <= 600000, 13906834659674685441);
        let v2 = construct_badge_attestation_message(0x2::object::id<0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile>(arg0), &arg1, arg3);
        0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::oracle_utils::verify_oracle_signature(&v2, &v0, &arg2);
        let v3 = 0x1::string::utf8(b"badge_collection");
        if (!0x2::dynamic_field::exists_<0x1::string::String>(0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::uid(arg0), v3)) {
            let v4 = BadgeCollection{
                badges       : 0x1::vector::empty<Badge>(),
                last_updated : v1,
            };
            0x2::dynamic_field::add<0x1::string::String, BadgeCollection>(0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::uid_mut(arg0), v3, v4);
        };
        let v5 = 0x2::dynamic_field::borrow_mut<0x1::string::String, BadgeCollection>(0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::uid_mut(arg0), v3);
        update_badge_collection_with_events(v5, deserialize_badges(&arg1, v1), 0x2::object::id<0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::Profile>(arg0), 0xa824359b3507f1255dc6d4daf29383aab5ae77e726effeac3922b6f1fc29da67::profile::owner(arg0), v1);
        v5.last_updated = v1;
    }

    fun should_update_badge(arg0: &Badge, arg1: &Badge) : bool {
        arg0.tier_number > arg1.tier_number
    }

    fun update_badge_collection_with_events(arg0: &mut BadgeCollection, arg1: vector<Badge>, arg2: 0x2::object::ID, arg3: address, arg4: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Badge>(&arg1)) {
            let v1 = 0x1::vector::borrow<Badge>(&arg1, v0);
            let (v2, v3) = find_badge_by_category(arg0, &v1.category);
            if (v2) {
                let v4 = 0x1::vector::borrow_mut<Badge>(&mut arg0.badges, v3);
                if (should_update_badge(v1, v4)) {
                    let v5 = BadgeUpdatedEvent{
                        profile_id      : arg2,
                        profile_owner   : arg3,
                        category        : v1.category,
                        old_tier        : v4.tier,
                        new_tier        : v1.tier,
                        old_tier_number : v4.tier_number,
                        new_tier_number : v1.tier_number,
                        display_name    : v1.display_name,
                        description     : v1.description,
                        image_url       : v1.image_url,
                        timestamp       : arg4,
                    };
                    0x2::event::emit<BadgeUpdatedEvent>(v5);
                    *v4 = *v1;
                };
            } else {
                let v6 = BadgeMintedEvent{
                    profile_id    : arg2,
                    profile_owner : arg3,
                    category      : v1.category,
                    tier          : v1.tier,
                    display_name  : v1.display_name,
                    description   : v1.description,
                    image_url     : v1.image_url,
                    tier_number   : v1.tier_number,
                    timestamp     : arg4,
                };
                0x2::event::emit<BadgeMintedEvent>(v6);
                0x1::vector::push_back<Badge>(&mut arg0.badges, *v1);
            };
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v6
}

