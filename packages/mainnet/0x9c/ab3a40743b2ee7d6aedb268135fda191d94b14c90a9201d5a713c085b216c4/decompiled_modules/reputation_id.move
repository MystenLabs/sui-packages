module 0x9cab3a40743b2ee7d6aedb268135fda191d94b14c90a9201d5a713c085b216c4::reputation_id {
    struct ReputationProfile has key {
        id: 0x2::object::UID,
        user: address,
        score: u64,
        total_interactions: u64,
        last_updated: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AttestorCap has store, key {
        id: 0x2::object::UID,
        protocol_name: 0x1::string::String,
    }

    struct ProfileCreated has copy, drop {
        user: address,
        profile_id: 0x2::object::ID,
    }

    struct ScoreUpdated has copy, drop {
        user: address,
        new_score: u64,
        protocol: 0x1::string::String,
    }

    public fun authorize_attestor(arg0: &AdminCap, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = AttestorCap{
            id            : 0x2::object::new(arg3),
            protocol_name : 0x1::string::utf8(arg1),
        };
        0x2::transfer::public_transfer<AttestorCap>(v0, arg2);
    }

    public fun create_profile(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ReputationProfile{
            id                 : 0x2::object::new(arg0),
            user               : 0x2::tx_context::sender(arg0),
            score              : 500,
            total_interactions : 0,
            last_updated       : 0x2::tx_context::epoch(arg0),
        };
        let v1 = ProfileCreated{
            user       : 0x2::tx_context::sender(arg0),
            profile_id : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::event::emit<ProfileCreated>(v1);
        0x2::transfer::share_object<ReputationProfile>(v0);
    }

    public fun get_score(arg0: &ReputationProfile) : u64 {
        arg0.score
    }

    public fun init_admin(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun update_reputation(arg0: &AttestorCap, arg1: &mut ReputationProfile, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            arg1.score = arg1.score + arg2;
            if (arg1.score > 1000) {
                arg1.score = 1000;
            };
        } else if (arg1.score > arg2) {
            arg1.score = arg1.score - arg2;
        } else {
            arg1.score = 0;
        };
        arg1.total_interactions = arg1.total_interactions + 1;
        arg1.last_updated = 0x2::tx_context::epoch(arg4);
        let v0 = ScoreUpdated{
            user      : arg1.user,
            new_score : arg1.score,
            protocol  : arg0.protocol_name,
        };
        0x2::event::emit<ScoreUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

