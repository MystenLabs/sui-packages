module 0xc218831e411e4c21f911c299053828a589cf24d58cfad80b2a5711571993ab3a::game {
    struct GAME has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GameConfig has key {
        id: 0x2::object::UID,
        session_counter: u64,
        current_session: 0x1::option::Option<0x2::object::ID>,
        easy_img_blob: 0x1::string::String,
        medium_img_blob: 0x1::string::String,
        hard_img_blob: 0x1::string::String,
    }

    struct Session has key {
        id: 0x2::object::UID,
        session_id: u64,
        digest: 0x1::string::String,
        difficulty: u8,
        blob_id: 0x1::string::String,
        hint: 0x1::string::String,
        block_num: u64,
        allowlist: vector<address>,
        minted: bool,
        expires_at: u64,
    }

    struct AllowlistCap has store, key {
        id: 0x2::object::UID,
        session_id: u64,
        session_obj: 0x2::object::ID,
    }

    struct TxnHuntNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        metadata_url: 0x1::string::String,
        difficulty: u8,
        block_num: u64,
        points: u64,
        session_id: u64,
        solved_at: u64,
    }

    struct SessionCreated has copy, drop {
        session_id: u64,
        difficulty: u8,
        expires_at: u64,
    }

    struct AnswerSubmitted has copy, drop {
        session_id: u64,
        solver: address,
    }

    struct NFTMinted has copy, drop {
        session_id: u64,
        winner: address,
        difficulty: u8,
        points: u64,
    }

    fun build_nft_description(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"Solved block ");
        0x1::string::append(&mut v0, u64_to_string(arg0));
        0x1::string::append(&mut v0, 0x1::string::utf8(b" on Sui mainnet."));
        v0
    }

    fun build_nft_name(arg0: u64, arg1: u8) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"TxnHunt #");
        0x1::string::append(&mut v0, u64_to_string(arg0));
        0x1::string::append(&mut v0, 0x1::string::utf8(x"20e2809420"));
        if (arg1 == 1) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"Easy"));
        } else if (arg1 == 2) {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"Medium"));
        } else {
            0x1::string::append(&mut v0, 0x1::string::utf8(b"Hard"));
        };
        v0
    }

    fun build_walrus_url(arg0: &0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/");
        0x1::string::append(&mut v0, *arg0);
        v0
    }

    public fun config_counter(arg0: &GameConfig) : u64 {
        arg0.session_counter
    }

    public fun config_current_session(arg0: &GameConfig) : 0x1::option::Option<0x2::object::ID> {
        arg0.current_session
    }

    public fun create_game_witness() : 0xc218831e411e4c21f911c299053828a589cf24d58cfad80b2a5711571993ab3a::leaderboard::GameWitness {
        0xc218831e411e4c21f911c299053828a589cf24d58cfad80b2a5711571993ab3a::leaderboard::new_game_witness()
    }

    public entry fun create_session(arg0: &AdminCap, arg1: &mut GameConfig, arg2: vector<u8>, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg3 == 1) {
            true
        } else if (arg3 == 2) {
            true
        } else {
            arg3 == 3
        };
        assert!(v0, 8);
        assert!(0x2::clock::timestamp_ms(arg8) < arg7, 4);
        arg1.session_counter = arg1.session_counter + 1;
        let v1 = arg1.session_counter;
        let v2 = Session{
            id         : 0x2::object::new(arg9),
            session_id : v1,
            digest     : 0x1::string::utf8(arg2),
            difficulty : arg3,
            blob_id    : 0x1::string::utf8(arg4),
            hint       : 0x1::string::utf8(arg5),
            block_num  : arg6,
            allowlist  : vector[],
            minted     : false,
            expires_at : arg7,
        };
        let v3 = SessionCreated{
            session_id : v1,
            difficulty : arg3,
            expires_at : arg7,
        };
        0x2::event::emit<SessionCreated>(v3);
        0x2::transfer::share_object<Session>(v2);
        arg1.current_session = 0x1::option::some<0x2::object::ID>(0x2::object::id<Session>(&v2));
    }

    fun difficulty_points(arg0: u8) : u64 {
        if (arg0 == 1) {
            1
        } else if (arg0 == 2) {
            2
        } else {
            3
        }
    }

    fun init(arg0: GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GAME>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        let v5 = 0x2::display::new_with_fields<TxnHuntNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<TxnHuntNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::display::Display<TxnHuntNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = GameConfig{
            id              : 0x2::object::new(arg1),
            session_counter : 0,
            current_session : 0x1::option::none<0x2::object::ID>(),
            easy_img_blob   : 0x1::string::utf8(b""),
            medium_img_blob : 0x1::string::utf8(b""),
            hard_img_blob   : 0x1::string::utf8(b""),
        };
        0x2::transfer::share_object<GameConfig>(v7);
    }

    public fun is_in_allowlist(arg0: &Session, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.allowlist, &arg1)
    }

    public entry fun mint_nft(arg0: &mut Session, arg1: AllowlistCap, arg2: &GameConfig, arg3: vector<u8>, arg4: &mut 0xc218831e411e4c21f911c299053828a589cf24d58cfad80b2a5711571993ab3a::leaderboard::Leaderboard, arg5: 0xc218831e411e4c21f911c299053828a589cf24d58cfad80b2a5711571993ab3a::leaderboard::GameWitness, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg1.session_id == arg0.session_id, 6);
        assert!(arg1.session_obj == 0x2::object::id<Session>(arg0), 6);
        assert!(!arg0.minted, 3);
        assert!(v0 < arg0.expires_at, 4);
        let v1 = 0x2::tx_context::sender(arg7);
        assert!(0x1::vector::contains<address>(&arg0.allowlist, &v1), 5);
        arg0.minted = true;
        let v2 = &mut arg0.allowlist;
        remove_from_allowlist(v2, v1);
        let v3 = difficulty_points(arg0.difficulty);
        let v4 = resolve_image_blob(arg2, arg0.difficulty);
        let v5 = 0x1::string::utf8(arg3);
        let v6 = TxnHuntNFT{
            id           : 0x2::object::new(arg7),
            name         : build_nft_name(arg0.session_id, arg0.difficulty),
            description  : build_nft_description(arg0.block_num),
            image_url    : build_walrus_url(&v4),
            metadata_url : build_walrus_url(&v5),
            difficulty   : arg0.difficulty,
            block_num    : arg0.block_num,
            points       : v3,
            session_id   : arg0.session_id,
            solved_at    : v0,
        };
        let v7 = NFTMinted{
            session_id : arg0.session_id,
            winner     : v1,
            difficulty : arg0.difficulty,
            points     : v3,
        };
        0x2::event::emit<NFTMinted>(v7);
        0xc218831e411e4c21f911c299053828a589cf24d58cfad80b2a5711571993ab3a::leaderboard::add_score(arg4, arg5, v1, v3, arg6, arg7);
        let AllowlistCap {
            id          : v8,
            session_id  : _,
            session_obj : _,
        } = arg1;
        0x2::object::delete(v8);
        0x2::transfer::transfer<TxnHuntNFT>(v6, v1);
    }

    fun remove_from_allowlist(arg0: &mut vector<address>, arg1: address) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                0x1::vector::remove<address>(arg0, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    fun resolve_image_blob(arg0: &GameConfig, arg1: u8) : 0x1::string::String {
        if (arg1 == 1) {
            arg0.easy_img_blob
        } else if (arg1 == 2) {
            arg0.medium_img_blob
        } else {
            arg0.hard_img_blob
        }
    }

    public fun seal_approve(arg0: vector<u8>, arg1: &AllowlistCap, arg2: &Session, arg3: &0x2::clock::Clock) {
        assert!(arg1.session_id == arg2.session_id, 6);
        assert!(arg1.session_obj == 0x2::object::id<Session>(arg2), 6);
        assert!(!arg2.minted, 3);
        assert!(0x2::clock::timestamp_ms(arg3) < arg2.expires_at, 4);
    }

    public fun session_blob_id(arg0: &Session) : &0x1::string::String {
        &arg0.blob_id
    }

    public fun session_block_num(arg0: &Session) : u64 {
        arg0.block_num
    }

    public fun session_difficulty(arg0: &Session) : u8 {
        arg0.difficulty
    }

    public fun session_expires_at(arg0: &Session) : u64 {
        arg0.expires_at
    }

    public fun session_hint(arg0: &Session) : &0x1::string::String {
        &arg0.hint
    }

    public fun session_id(arg0: &Session) : u64 {
        arg0.session_id
    }

    public fun session_minted(arg0: &Session) : bool {
        arg0.minted
    }

    public entry fun set_nft_images(arg0: &AdminCap, arg1: &mut GameConfig, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        arg1.easy_img_blob = 0x1::string::utf8(arg2);
        arg1.medium_img_blob = 0x1::string::utf8(arg3);
        arg1.hard_img_blob = 0x1::string::utf8(arg4);
    }

    public entry fun submit_answer(arg0: &mut Session, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.expires_at, 4);
        assert!(!arg0.minted, 3);
        assert!(0x1::string::utf8(arg1) == arg0.digest, 2);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x1::vector::contains<address>(&arg0.allowlist, &v0), 7);
        0x1::vector::push_back<address>(&mut arg0.allowlist, v0);
        let v1 = AllowlistCap{
            id          : 0x2::object::new(arg3),
            session_id  : arg0.session_id,
            session_obj : 0x2::object::id<Session>(arg0),
        };
        let v2 = AnswerSubmitted{
            session_id : arg0.session_id,
            solver     : v0,
        };
        0x2::event::emit<AnswerSubmitted>(v2);
        0x2::transfer::transfer<AllowlistCap>(v1, v0);
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v7
}

