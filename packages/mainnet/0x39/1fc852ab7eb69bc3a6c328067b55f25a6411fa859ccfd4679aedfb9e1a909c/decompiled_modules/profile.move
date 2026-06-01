module 0x391fc852ab7eb69bc3a6c328067b55f25a6411fa859ccfd4679aedfb9e1a909c::profile {
    struct Profile has store, key {
        id: 0x2::object::UID,
        owner: address,
        username: 0x1::string::String,
        walrus_avatar_blob: 0x1::string::String,
        walrus_banner_blob: 0x1::string::String,
        bio_blob: 0x1::string::String,
        created_at: u64,
        verified: bool,
    }

    public entry fun create_profile(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::object::new(arg5);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        let v3 = Profile{
            id                 : v1,
            owner              : v0,
            username           : arg0,
            walrus_avatar_blob : arg1,
            walrus_banner_blob : arg2,
            bio_blob           : arg3,
            created_at         : v2,
            verified           : false,
        };
        0x2::transfer::transfer<Profile>(v3, v0);
        0x391fc852ab7eb69bc3a6c328067b55f25a6411fa859ccfd4679aedfb9e1a909c::events::emit_profile_created(0x2::object::uid_to_inner(&v1), v0, arg0, v2);
    }

    public fun get_owner(arg0: &Profile) : address {
        arg0.owner
    }

    public fun get_username(arg0: &Profile) : &0x1::string::String {
        &arg0.username
    }

    public fun is_verified(arg0: &Profile) : bool {
        arg0.verified
    }

    public entry fun update_profile(arg0: &mut Profile, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 0);
        arg0.walrus_avatar_blob = arg1;
        arg0.walrus_banner_blob = arg2;
        arg0.bio_blob = arg3;
    }

    public entry fun verify_profile(arg0: &mut Profile, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.verified = arg1;
    }

    // decompiled from Move bytecode v7
}

