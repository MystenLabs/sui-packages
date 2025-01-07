module 0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::aifrens_lol {
    struct AIFRENS_LOL has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintEvent has copy, drop {
        id: 0x2::object::ID,
        creator: address,
        generation: u64,
        genes: vector<u8>,
        number: u64,
    }

    struct AifrensLolPool has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        has_paused: bool,
        launched_at_ms: u64,
        expired_at_ms: u64,
        claimed: 0x2::table::Table<address, bool>,
        root_proof: vector<u8>,
    }

    struct PublicLolPool has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        has_paused: bool,
        launched_at_ms: u64,
        expired_at_ms: u64,
        claimed: 0x2::table::Table<address, bool>,
    }

    struct BetaLolPool has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        has_paused: bool,
        launched_at_ms: u64,
        expired_at_ms: u64,
        claimed: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct AifrensLol has store, key {
        id: 0x2::object::UID,
        generation: u64,
        birthdate: u64,
        genes: vector<u8>,
        number: u64,
        class: 0x1::string::String,
    }

    public entry fun claim(arg0: &mut AifrensLolPool, arg1: &0x2::clock::Clock, arg2: vector<vector<u8>>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(!arg0.has_paused, 4);
        assert!(v0 > arg0.launched_at_ms, 5);
        assert!(v0 < arg0.expired_at_ms, 6);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed, v1), 2);
        0x2::table::add<address, bool>(&mut arg0.claimed, v1, true);
        assert!(0x5609295085042153b81e7453ee0eba7f173cc66d05d388e636e03a7d927b7368::merkle_tree::verify_calldata(arg2, arg0.root_proof, 0x1::bcs::to_bytes<address>(&v1)), 3);
        mint_token(arg1, 0x2::table::length<address, bool>(&arg0.claimed), arg0.name, arg3);
    }

    public entry fun beta_claim(arg0: &mut BetaLolPool, arg1: &0x2::clock::Clock, arg2: &0x6c830e5e4d2a083c77a0020c12b645b1647d2835170f9eab422e5ffb5cad6d44::aifrens_footie_legends::AifrensGenesis, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(!arg0.has_paused, 4);
        assert!(v0 > arg0.launched_at_ms, 5);
        assert!(v0 < arg0.expired_at_ms, 6);
        let v1 = 0x2::object::id<0x6c830e5e4d2a083c77a0020c12b645b1647d2835170f9eab422e5ffb5cad6d44::aifrens_footie_legends::AifrensGenesis>(arg2);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.claimed, v1), 2);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.claimed, v1, true);
        mint_token(arg1, 0x2::table::length<0x2::object::ID, bool>(&arg0.claimed), arg0.name, arg3);
    }

    public fun burn_token(arg0: AifrensLol) {
        let AifrensLol {
            id         : v0,
            generation : _,
            birthdate  : _,
            genes      : _,
            number     : _,
            class      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun get_random(arg0: &0x2::clock::Clock, arg1: 0x1::string::String, arg2: address, arg3: u64) : vector<u8> {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&v0));
        0x1::vector::append<u8>(&mut v1, *0x1::string::bytes(&arg1));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<address>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg3));
        0x2::hash::keccak256(&v1)
    }

    fun init(arg0: AIFRENS_LOL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"AIFRENS Hooman Always Late"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://explorer.sui.io/object/{id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://api.suifrens.ai/nft/aifrens-hooman-always-late-{class}.png?id={id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"AIFRENS Hooman Always Late NFT is the result of a joint effort between the AIFRENS community and team. Through battle-testing the claiming process, we are better preparing for the official $AIFRENS token launch via airdrop. These NFTs will also serve as boosters in the AIFRENS Footie Legends Fusion process, increasing the chances of unlocking rare legends."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://suifrens.ai/"));
        let v5 = 0x2::package::claim<AIFRENS_LOL>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<AifrensLol>(&v5, v1, v3, arg1);
        0x2::display::update_version<AifrensLol>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, v0);
        0x2::transfer::public_transfer<0x2::display::Display<AifrensLol>>(v6, v0);
        let v7 = AifrensLolPool{
            id             : 0x2::object::new(arg1),
            name           : 0x1::string::utf8(b"alpha"),
            has_paused     : false,
            launched_at_ms : 1,
            expired_at_ms  : 168398280000000,
            claimed        : 0x2::table::new<address, bool>(arg1),
            root_proof     : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<AifrensLolPool>(v7);
        let v8 = AifrensLolPool{
            id             : 0x2::object::new(arg1),
            name           : 0x1::string::utf8(b"eco"),
            has_paused     : false,
            launched_at_ms : 1,
            expired_at_ms  : 168398280000000,
            claimed        : 0x2::table::new<address, bool>(arg1),
            root_proof     : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::share_object<AifrensLolPool>(v8);
        let v9 = BetaLolPool{
            id             : 0x2::object::new(arg1),
            name           : 0x1::string::utf8(b"beta"),
            has_paused     : false,
            launched_at_ms : 1,
            expired_at_ms  : 168398280000000,
            claimed        : 0x2::table::new<0x2::object::ID, bool>(arg1),
        };
        0x2::transfer::share_object<BetaLolPool>(v9);
        let v10 = PublicLolPool{
            id             : 0x2::object::new(arg1),
            name           : 0x1::string::utf8(b"public"),
            has_paused     : false,
            launched_at_ms : 1,
            expired_at_ms  : 168398280000000,
            claimed        : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<PublicLolPool>(v10);
        let v11 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v11, v0);
    }

    fun is_emergency(arg0: &AifrensLolPool) : bool {
        arg0.has_paused
    }

    fun mint_token(arg0: &0x2::clock::Clock, arg1: u64, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = get_random(arg0, arg2, v0, arg1);
        let v2 = AifrensLol{
            id         : 0x2::object::new(arg3),
            generation : 0,
            birthdate  : 0x2::clock::timestamp_ms(arg0),
            genes      : v1,
            number     : arg1,
            class      : arg2,
        };
        let v3 = MintEvent{
            id         : 0x2::object::uid_to_inner(&v2.id),
            creator    : v0,
            generation : 0,
            genes      : v1,
            number     : arg1,
        };
        0x2::event::emit<MintEvent>(v3);
        0x2::transfer::transfer<AifrensLol>(v2, v0);
    }

    public fun pause(arg0: &AdminCap, arg1: &mut AifrensLolPool) {
        arg1.has_paused = true;
    }

    public fun pause_beta(arg0: &AdminCap, arg1: &mut BetaLolPool) {
        arg1.has_paused = true;
    }

    public fun pause_public(arg0: &AdminCap, arg1: &mut PublicLolPool) {
        arg1.has_paused = true;
    }

    public entry fun public_claim(arg0: &mut PublicLolPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(!arg0.has_paused, 4);
        assert!(v0 > arg0.launched_at_ms, 5);
        assert!(v0 < arg0.expired_at_ms, 6);
        let v1 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed, v1), 2);
        0x2::table::add<address, bool>(&mut arg0.claimed, v1, true);
        mint_token(arg1, 0x2::table::length<address, bool>(&arg0.claimed), arg0.name, arg2);
    }

    public fun resume(arg0: &AdminCap, arg1: &mut AifrensLolPool) {
        arg1.has_paused = false;
    }

    public fun resume_beta(arg0: &AdminCap, arg1: &mut BetaLolPool) {
        arg1.has_paused = false;
    }

    public fun resume_public(arg0: &AdminCap, arg1: &mut PublicLolPool) {
        arg1.has_paused = false;
    }

    public entry fun set_proof_root(arg0: &AdminCap, arg1: &mut AifrensLolPool, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.root_proof = arg2;
    }

    public entry fun update_beta_time(arg0: &AdminCap, arg1: &mut BetaLolPool, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.launched_at_ms = arg2;
        arg1.expired_at_ms = arg3;
    }

    public entry fun update_time(arg0: &AdminCap, arg1: &mut AifrensLolPool, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.launched_at_ms = arg2;
        arg1.expired_at_ms = arg3;
    }

    // decompiled from Move bytecode v6
}

