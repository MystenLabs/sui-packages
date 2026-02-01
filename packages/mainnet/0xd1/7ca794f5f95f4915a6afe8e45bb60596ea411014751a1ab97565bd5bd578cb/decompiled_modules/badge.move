module 0xd17ca794f5f95f4915a6afe8e45bb60596ea411014751a1ab97565bd5bd578cb::badge {
    struct BadgeEarned has copy, drop {
        badge_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        badge_type: 0x1::string::String,
        tier: u8,
        earned_at: u64,
    }

    struct BadgeRevoked has copy, drop {
        badge_id: 0x2::object::ID,
        agent_id: 0x2::object::ID,
        revoked_at: u64,
    }

    struct Badge has key {
        id: 0x2::object::UID,
        agent_id: 0x2::object::ID,
        badge_type: 0x1::string::String,
        tier: u8,
        earned_at: u64,
        metadata_uri: 0x1::option::Option<0x1::string::String>,
    }

    public fun id(arg0: &Badge) : 0x2::object::ID {
        0x2::object::id<Badge>(arg0)
    }

    public fun agent_id(arg0: &Badge) : 0x2::object::ID {
        arg0.agent_id
    }

    public(friend) fun award(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u8, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        let v1 = Badge{
            id           : 0x2::object::new(arg4),
            agent_id     : arg0,
            badge_type   : arg1,
            tier         : arg2,
            earned_at    : v0,
            metadata_uri : arg3,
        };
        let v2 = BadgeEarned{
            badge_id   : 0x2::object::id<Badge>(&v1),
            agent_id   : arg0,
            badge_type : v1.badge_type,
            tier       : arg2,
            earned_at  : v0,
        };
        0x2::event::emit<BadgeEarned>(v2);
        0x2::transfer::share_object<Badge>(v1);
    }

    public fun award_custom(arg0: &0xd17ca794f5f95f4915a6afe8e45bb60596ea411014751a1ab97565bd5bd578cb::agent::Agent, arg1: 0x1::string::String, arg2: u8, arg3: 0x1::option::Option<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xd17ca794f5f95f4915a6afe8e45bb60596ea411014751a1ab97565bd5bd578cb::agent::owner(arg0) == 0x2::tx_context::sender(arg4), 0);
        assert!(arg2 <= 3, 20);
        award(0x2::object::id<0xd17ca794f5f95f4915a6afe8e45bb60596ea411014751a1ab97565bd5bd578cb::agent::Agent>(arg0), arg1, arg2, arg3, arg4);
    }

    public fun award_first_task(arg0: &0xd17ca794f5f95f4915a6afe8e45bb60596ea411014751a1ab97565bd5bd578cb::agent::Agent, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xd17ca794f5f95f4915a6afe8e45bb60596ea411014751a1ab97565bd5bd578cb::agent::owner(arg0) == 0x2::tx_context::sender(arg1), 0);
        award(0x2::object::id<0xd17ca794f5f95f4915a6afe8e45bb60596ea411014751a1ab97565bd5bd578cb::agent::Agent>(arg0), 0x1::string::utf8(b"first_task"), 0, 0x1::option::none<0x1::string::String>(), arg1);
    }

    public fun award_verified_identity(arg0: &0xd17ca794f5f95f4915a6afe8e45bb60596ea411014751a1ab97565bd5bd578cb::agent::Agent, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xd17ca794f5f95f4915a6afe8e45bb60596ea411014751a1ab97565bd5bd578cb::agent::owner(arg0) == 0x2::tx_context::sender(arg1), 0);
        award(0x2::object::id<0xd17ca794f5f95f4915a6afe8e45bb60596ea411014751a1ab97565bd5bd578cb::agent::Agent>(arg0), 0x1::string::utf8(b"verified_identity"), 0, 0x1::option::none<0x1::string::String>(), arg1);
    }

    public fun badge_type(arg0: &Badge) : 0x1::string::String {
        arg0.badge_type
    }

    public fun earned_at(arg0: &Badge) : u64 {
        arg0.earned_at
    }

    public fun metadata_uri(arg0: &Badge) : 0x1::option::Option<0x1::string::String> {
        arg0.metadata_uri
    }

    public fun tier(arg0: &Badge) : u8 {
        arg0.tier
    }

    public fun tier_name(arg0: &Badge) : 0x1::string::String {
        if (arg0.tier == 0) {
            0x1::string::utf8(b"bronze")
        } else if (arg0.tier == 1) {
            0x1::string::utf8(b"silver")
        } else if (arg0.tier == 2) {
            0x1::string::utf8(b"gold")
        } else {
            0x1::string::utf8(b"platinum")
        }
    }

    // decompiled from Move bytecode v6
}

