module 0x5760b2685d41bd45e2991dedc242e866b1aca9ff3c3a5e193445751c2b8dfe4b::chronicle {
    struct CHRONICLE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ChronicleRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        max_battle_id: u8,
        max_hero_id: u8,
        counts: 0x2::table::Table<u8, u64>,
        authority_pubkey: vector<u8>,
        used_nonces: 0x2::table::Table<u64, bool>,
    }

    struct Chronicle has store, key {
        id: 0x2::object::UID,
        battle_id: u8,
        hero_id: u8,
        title: 0x1::string::String,
        inscription: 0x1::string::String,
        hp_pct: u8,
        tier: u8,
        mint_order: u64,
        is_first_chronicler: bool,
        mint_timestamp_ms: u64,
        metadata_blob_id: 0x1::string::String,
        player: address,
    }

    struct ChronicleMinted has copy, drop {
        chronicle_id: 0x2::object::ID,
        player: address,
        battle_id: u8,
        mint_order: u64,
        tier: u8,
        is_first: bool,
    }

    fun assert_active(arg0: &ChronicleRegistry) {
        assert!(arg0.version == 1, 16);
        assert!(!arg0.paused, 17);
    }

    public fun battle_id(arg0: &Chronicle) : u8 {
        arg0.battle_id
    }

    fun build_voucher_message(arg0: address, arg1: address, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: u64) : vector<u8> {
        let v0 = b"ConSSSWars/chronicle-voucher/v1";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u8>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u8>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u8>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg6));
        v0
    }

    fun compute_tier(arg0: u64, arg1: u8) : u8 {
        let v0 = if (arg0 <= 100) {
            2
        } else if (arg0 <= 300) {
            1
        } else {
            0
        };
        if (arg1 >= 80) {
            v0 + 1
        } else {
            v0
        }
    }

    public fun count_for_battle(arg0: &ChronicleRegistry, arg1: u8) : u64 {
        current_count(arg0, arg1)
    }

    fun current_count(arg0: &ChronicleRegistry, arg1: u8) : u64 {
        if (0x2::table::contains<u8, u64>(&arg0.counts, arg1)) {
            *0x2::table::borrow<u8, u64>(&arg0.counts, arg1)
        } else {
            0
        }
    }

    public fun hero_id(arg0: &Chronicle) : u8 {
        arg0.hero_id
    }

    public fun hp_pct(arg0: &Chronicle) : u8 {
        arg0.hp_pct
    }

    fun init(arg0: CHRONICLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CHRONICLE>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"tier"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"walrus_blob_id"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"walrus_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{title}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A Chronicle of the Chainoa Eternal Chronicles. Battle {battle_id}, written by chronicler #{mint_order}."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://conssslab.github.io/public-assets/chronicle/battle-{battle_id}-{tier}.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://conssswars.com"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"ConsssLab"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{tier}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{metadata_blob_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/{metadata_blob_id}"));
        let v5 = 0x2::display::new_with_fields<Chronicle>(&v0, v1, v3, arg1);
        0x2::display::update_version<Chronicle>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Chronicle>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = ChronicleRegistry{
            id               : 0x2::object::new(arg1),
            version          : 1,
            paused           : false,
            max_battle_id    : 3,
            max_hero_id      : 20,
            counts           : 0x2::table::new<u8, u64>(arg1),
            authority_pubkey : 0x1::vector::empty<u8>(),
            used_nonces      : 0x2::table::new<u64, bool>(arg1),
        };
        0x2::transfer::share_object<ChronicleRegistry>(v7);
    }

    public fun inscription(arg0: &Chronicle) : &0x1::string::String {
        &arg0.inscription
    }

    public fun is_first_chronicler(arg0: &Chronicle) : bool {
        arg0.is_first_chronicler
    }

    public fun is_paused(arg0: &ChronicleRegistry) : bool {
        arg0.paused
    }

    public fun metadata_blob_id(arg0: &Chronicle) : &0x1::string::String {
        &arg0.metadata_blob_id
    }

    public entry fun migrate(arg0: &AdminCap, arg1: &mut ChronicleRegistry) {
        assert!(arg1.version < 1, 18);
        arg1.version = 1;
    }

    public entry fun mint_chronicle(arg0: &mut ChronicleRegistry, arg1: u8, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert!(arg1 >= 1 && arg1 <= arg0.max_battle_id, 3);
        assert!(arg2 >= 1 && arg2 <= arg0.max_hero_id, 4);
        assert!(arg5 <= 100, 9);
        let v0 = 0x1::vector::length<u8>(&arg3);
        assert!(v0 > 0, 6);
        assert!(v0 <= 320, 1);
        assert!(0x1::vector::length<u8>(&arg4) <= 200, 2);
        let v1 = 0x1::vector::length<u8>(&arg6);
        assert!(v1 > 0, 7);
        assert!(v1 <= 128, 8);
        let v2 = 0x2::tx_context::sender(arg11);
        assert!(0x1::vector::length<u8>(&arg0.authority_pubkey) == 32, 10);
        assert!(0x2::clock::timestamp_ms(arg10) <= arg8, 11);
        assert!(!0x2::table::contains<u64, bool>(&arg0.used_nonces, arg7), 12);
        assert!(0x1::vector::length<u8>(&arg9) == 64, 19);
        let v3 = build_voucher_message(0x2::object::id_address<ChronicleRegistry>(arg0), v2, arg1, arg2, arg5, arg7, arg8);
        assert!(0x2::ed25519::ed25519_verify(&arg9, &arg0.authority_pubkey, &v3), 13);
        0x2::table::add<u64, bool>(&mut arg0.used_nonces, arg7, true);
        let v4 = current_count(arg0, arg1);
        assert!(v4 < 1000, 14);
        let v5 = v4 + 1;
        set_count(arg0, arg1, v5);
        let v6 = compute_tier(v5, arg5);
        let v7 = Chronicle{
            id                  : 0x2::object::new(arg11),
            battle_id           : arg1,
            hero_id             : arg2,
            title               : 0x1::string::utf8(arg3),
            inscription         : 0x1::string::utf8(arg4),
            hp_pct              : arg5,
            tier                : v6,
            mint_order          : v5,
            is_first_chronicler : v5 == 1,
            mint_timestamp_ms   : 0x2::clock::timestamp_ms(arg10),
            metadata_blob_id    : 0x1::string::utf8(arg6),
            player              : v2,
        };
        let v8 = ChronicleMinted{
            chronicle_id : 0x2::object::id<Chronicle>(&v7),
            player       : v2,
            battle_id    : arg1,
            mint_order   : v5,
            tier         : v6,
            is_first     : v5 == 1,
        };
        0x2::event::emit<ChronicleMinted>(v8);
        0x2::transfer::public_transfer<Chronicle>(v7, v2);
    }

    public fun mint_order(arg0: &Chronicle) : u64 {
        arg0.mint_order
    }

    public fun mint_timestamp_ms(arg0: &Chronicle) : u64 {
        arg0.mint_timestamp_ms
    }

    public fun player(arg0: &Chronicle) : address {
        arg0.player
    }

    public entry fun set_authority_pubkey(arg0: &AdminCap, arg1: &mut ChronicleRegistry, arg2: vector<u8>) {
        assert!(arg1.version == 1, 16);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 15);
        arg1.authority_pubkey = arg2;
    }

    fun set_count(arg0: &mut ChronicleRegistry, arg1: u8, arg2: u64) {
        if (0x2::table::contains<u8, u64>(&arg0.counts, arg1)) {
            *0x2::table::borrow_mut<u8, u64>(&mut arg0.counts, arg1) = arg2;
        } else {
            0x2::table::add<u8, u64>(&mut arg0.counts, arg1, arg2);
        };
    }

    public entry fun set_max_battle_id(arg0: &AdminCap, arg1: &mut ChronicleRegistry, arg2: u8) {
        assert!(arg1.version == 1, 16);
        assert!(arg2 >= 1, 3);
        arg1.max_battle_id = arg2;
    }

    public entry fun set_max_hero_id(arg0: &AdminCap, arg1: &mut ChronicleRegistry, arg2: u8) {
        assert!(arg1.version == 1, 16);
        assert!(arg2 >= 1, 4);
        arg1.max_hero_id = arg2;
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut ChronicleRegistry, arg2: bool) {
        assert!(arg1.version == 1, 16);
        arg1.paused = arg2;
    }

    public fun tier(arg0: &Chronicle) : u8 {
        arg0.tier
    }

    public fun title(arg0: &Chronicle) : &0x1::string::String {
        &arg0.title
    }

    public fun version(arg0: &ChronicleRegistry) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

