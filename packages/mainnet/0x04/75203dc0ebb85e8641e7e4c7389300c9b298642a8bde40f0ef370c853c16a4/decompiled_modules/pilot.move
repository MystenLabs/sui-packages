module 0x475203dc0ebb85e8641e7e4c7389300c9b298642a8bde40f0ef370c853c16a4::pilot {
    struct PILOT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GameConfig has key {
        id: 0x2::object::UID,
        version: u64,
        signer_pubkey: vector<u8>,
        tier_thresholds: vector<u64>,
        tier_names: vector<0x1::string::String>,
        licences: 0x2::table::Table<address, 0x2::object::ID>,
        paused: bool,
    }

    struct PilotLicence has key {
        id: 0x2::object::UID,
        pilot: address,
        high_score: u64,
        tier: u8,
        rank: 0x1::string::String,
        verified_runs: u64,
        last_nonce: u64,
        updated_ms: u64,
    }

    struct ScorePayload has copy, drop {
        domain: vector<u8>,
        kind: u8,
        pilot: address,
        licence: 0x2::object::ID,
        score: u64,
        nonce: u64,
        expires_ms: u64,
    }

    struct LicenceMinted has copy, drop {
        licence: 0x2::object::ID,
        pilot: address,
        score: u64,
        at_ms: u64,
    }

    struct ScoreRecorded has copy, drop {
        licence: 0x2::object::ID,
        pilot: address,
        score: u64,
        tier: u8,
        at_ms: u64,
    }

    public fun pilot(arg0: &PilotLicence) : address {
        arg0.pilot
    }

    fun assert_live(arg0: &GameConfig, arg1: u64, arg2: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 0);
        assert!(!arg0.paused, 1);
        assert!(0x1::vector::length<u8>(&arg0.signer_pubkey) == 32, 2);
        assert!(0x2::clock::timestamp_ms(arg2) <= arg1, 4);
    }

    fun assert_signed(arg0: &GameConfig, arg1: &ScorePayload, arg2: &vector<u8>) {
        let v0 = 0x2::bcs::to_bytes<ScorePayload>(arg1);
        assert!(0x2::ed25519::ed25519_verify(arg2, &arg0.signer_pubkey, &v0), 8);
    }

    public fun high_score(arg0: &PilotLicence) : u64 {
        arg0.high_score
    }

    fun init(arg0: PILOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PILOT>(arg0, arg1);
        let v1 = 0x2::display::new<PilotLicence>(&v0, arg1);
        0x2::display::add<PilotLicence>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"DeLorean Skyrun Pilot Licence: {high_score}"));
        0x2::display::add<PilotLicence>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Rank: {rank}. Verified high score {high_score} across {verified_runs} verified runs."));
        0x2::display::add<PilotLicence>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://deloreanskyrun.risemedia.app/api/card/{id}?s={high_score}"));
        0x2::display::add<PilotLicence>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://deloreanskyrun.risemedia.app/pilot/{id}"));
        0x2::display::add<PilotLicence>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://deloreanskyrun.risemedia.app"));
        0x2::display::add<PilotLicence>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"DeLorean Labs"));
        0x2::display::update_version<PilotLicence>(&mut v1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Cadet"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Pilot"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Ace"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Time Pilot"));
        let v4 = GameConfig{
            id              : 0x2::object::new(arg1),
            version         : 1,
            signer_pubkey   : b"",
            tier_thresholds : vector[0, 25, 50, 88],
            tier_names      : v2,
            licences        : 0x2::table::new<address, 0x2::object::ID>(arg1),
            paused          : false,
        };
        0x2::transfer::share_object<GameConfig>(v4);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v5);
        0x2::transfer::public_transfer<0x2::display::Display<PilotLicence>>(v1, v5);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, v5);
    }

    public fun licence_of(arg0: &GameConfig, arg1: address) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::table::contains<address, 0x2::object::ID>(&arg0.licences, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::table::borrow<address, 0x2::object::ID>(&arg0.licences, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut GameConfig) {
        assert!(arg1.version < 1, 0);
        arg1.version = 1;
    }

    public fun mint(arg0: &mut GameConfig, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert_live(arg0, arg3, arg5);
        assert!(!0x2::table::contains<address, 0x2::object::ID>(&arg0.licences, v0), 5);
        let v1 = ScorePayload{
            domain     : b"skyrun.v1",
            kind       : 0,
            pilot      : v0,
            licence    : 0x2::object::id_from_address(@0x0),
            score      : arg1,
            nonce      : arg2,
            expires_ms : arg3,
        };
        assert_signed(arg0, &v1, &arg4);
        let (v2, v3) = tier_for(arg0, arg1);
        let v4 = 0x2::clock::timestamp_ms(arg5);
        let v5 = PilotLicence{
            id            : 0x2::object::new(arg6),
            pilot         : v0,
            high_score    : arg1,
            tier          : v2,
            rank          : v3,
            verified_runs : 1,
            last_nonce    : arg2,
            updated_ms    : v4,
        };
        let v6 = 0x2::object::id<PilotLicence>(&v5);
        0x2::table::add<address, 0x2::object::ID>(&mut arg0.licences, v0, v6);
        let v7 = LicenceMinted{
            licence : v6,
            pilot   : v0,
            score   : arg1,
            at_ms   : v4,
        };
        0x2::event::emit<LicenceMinted>(v7);
        let v8 = ScoreRecorded{
            licence : v6,
            pilot   : v0,
            score   : arg1,
            tier    : v2,
            at_ms   : v4,
        };
        0x2::event::emit<ScoreRecorded>(v8);
        0x2::transfer::transfer<PilotLicence>(v5, v0);
    }

    public fun rank(arg0: &PilotLicence) : 0x1::string::String {
        arg0.rank
    }

    public fun record_score(arg0: &GameConfig, arg1: &mut PilotLicence, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert_live(arg0, arg4, arg6);
        assert!(arg1.pilot == v0, 9);
        assert!(arg3 > arg1.last_nonce, 6);
        assert!(arg2 > arg1.high_score, 7);
        let v1 = ScorePayload{
            domain     : b"skyrun.v1",
            kind       : 1,
            pilot      : v0,
            licence    : 0x2::object::id<PilotLicence>(arg1),
            score      : arg2,
            nonce      : arg3,
            expires_ms : arg4,
        };
        assert_signed(arg0, &v1, &arg5);
        let (v2, v3) = tier_for(arg0, arg2);
        let v4 = 0x2::clock::timestamp_ms(arg6);
        arg1.high_score = arg2;
        arg1.tier = v2;
        arg1.rank = v3;
        arg1.verified_runs = arg1.verified_runs + 1;
        arg1.last_nonce = arg3;
        arg1.updated_ms = v4;
        let v5 = ScoreRecorded{
            licence : 0x2::object::id<PilotLicence>(arg1),
            pilot   : v0,
            score   : arg2,
            tier    : v2,
            at_ms   : v4,
        };
        0x2::event::emit<ScoreRecorded>(v5);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut GameConfig, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun set_signer(arg0: &AdminCap, arg1: &mut GameConfig, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 3);
        arg1.signer_pubkey = arg2;
    }

    public fun set_tiers(arg0: &AdminCap, arg1: &mut GameConfig, arg2: vector<u64>, arg3: vector<0x1::string::String>) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        let v1 = if (v0 > 0) {
            if (v0 == 0x1::vector::length<0x1::string::String>(&arg3)) {
                if (v0 <= 255) {
                    *0x1::vector::borrow<u64>(&arg2, 0) == 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 10);
        let v2 = 1;
        while (v2 < v0) {
            assert!(*0x1::vector::borrow<u64>(&arg2, v2) > *0x1::vector::borrow<u64>(&arg2, v2 - 1), 10);
            v2 = v2 + 1;
        };
        arg1.tier_thresholds = arg2;
        arg1.tier_names = arg3;
    }

    public fun tier(arg0: &PilotLicence) : u8 {
        arg0.tier
    }

    fun tier_for(arg0: &GameConfig, arg1: u64) : (u8, 0x1::string::String) {
        let v0 = 0x1::vector::length<u64>(&arg0.tier_thresholds) - 1;
        while (v0 > 0 && arg1 < *0x1::vector::borrow<u64>(&arg0.tier_thresholds, v0)) {
            v0 = v0 - 1;
        };
        ((v0 as u8), *0x1::vector::borrow<0x1::string::String>(&arg0.tier_names, v0))
    }

    public fun verified_runs(arg0: &PilotLicence) : u64 {
        arg0.verified_runs
    }

    // decompiled from Move bytecode v7
}

