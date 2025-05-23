module 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::profile {
    struct PROFILE has drop {
        dummy_field: bool,
    }

    struct ProfileRegistry has store, key {
        id: 0x2::object::UID,
    }

    struct PimProfile has store {
        owner: address,
        xpubkey: vector<u8>,
        created_at: u64,
    }

    public fun add_profile(arg0: &mut ProfileRegistry, arg1: address, arg2: PimProfile) {
        assert!(!profile_exists(arg0, arg1), 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::errors::EProfileExists());
        0x2::dynamic_field::add<address, PimProfile>(&mut arg0.id, arg1, arg2);
    }

    public fun create_profile(arg0: &0x2::clock::Clock, arg1: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_xpubkey_valid(&arg2), 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::errors::EXPubKeyInvalid());
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::borrow_mut<ProfileRegistry>(arg1);
        assert!(!profile_exists(v1, v0), 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::errors::EProfileExists());
        let v2 = PimProfile{
            owner      : v0,
            xpubkey    : arg2,
            created_at : 0x2::clock::timestamp_ms(arg0),
        };
        add_profile(v1, v0, v2);
    }

    public fun get_owner(arg0: &PimProfile) : address {
        arg0.owner
    }

    public fun get_xpubkey(arg0: &PimProfile) : vector<u8> {
        arg0.xpubkey
    }

    public fun initialize(arg0: &mut 0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::Registry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ProfileRegistry{id: 0x2::object::new(arg1)};
        0x6490ecc049e7fe9e09525de43562dc63e645810e86c9f437993596772db5ffef::registry::add<ProfileRegistry>(arg0, v0);
    }

    fun is_xpubkey_valid(arg0: &vector<u8>) : bool {
        0x1::vector::length<u8>(arg0) == 0x99cc17deb41a7bfbc5057fc9878d41fe5457c2001c58030b66e012d436105bb6::constants::MAX_XPUBKEY_SIZE()
    }

    public fun profile_exists(arg0: &ProfileRegistry, arg1: address) : bool {
        0x2::dynamic_field::exists_with_type<address, PimProfile>(&arg0.id, arg1)
    }

    // decompiled from Move bytecode v6
}

