module 0x5760b2685d41bd45e2991dedc242e866b1aca9ff3c3a5e193445751c2b8dfe4b::echoes_of_chainoa {
    struct ECHOES_OF_CHAINOA has drop {
        dummy_field: bool,
    }

    struct FinaleRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        minted: 0x2::table::Table<address, bool>,
        total_minted: u64,
        authority_pubkey: vector<u8>,
        used_nonces: 0x2::table::Table<u64, bool>,
    }

    struct FinaleBadge has key {
        id: 0x2::object::UID,
        battle_id: u8,
        hero_id: u8,
        title: 0x1::string::String,
        inscription: 0x1::string::String,
        rating: u8,
        mint_order: u64,
        is_first_chronicler: bool,
        mint_timestamp_ms: u64,
        player: address,
    }

    struct FinaleBadgeMinted has copy, drop {
        badge_id: 0x2::object::ID,
        player: address,
        mint_order: u64,
        is_first: bool,
    }

    fun assert_active(arg0: &FinaleRegistry) {
        assert!(arg0.version == 1, 13);
        assert!(!arg0.paused, 14);
    }

    public fun battle_id(arg0: &FinaleBadge) : u8 {
        arg0.battle_id
    }

    fun build_voucher_message(arg0: address, arg1: address, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: u64) : vector<u8> {
        let v0 = b"ConSSSWars/finale-voucher/v1";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u8>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u8>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u8>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg6));
        v0
    }

    public fun has_minted(arg0: &FinaleRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.minted, arg1)
    }

    public fun hero_id(arg0: &FinaleBadge) : u8 {
        arg0.hero_id
    }

    fun init(arg0: ECHOES_OF_CHAINOA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ECHOES_OF_CHAINOA>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(x"56616c696461746f727327205769746e65737320e28094207b7469746c657d"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Soulbound. Cannot be transferred. Witness to the historic 90.9% validator vote at Crystal Sanctum, the night Suiren refused to fall."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://conssslab.github.io/public-assets/witness/seal.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://conssswars.com"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"ConsssLab"));
        let v5 = 0x2::display::new_with_fields<FinaleBadge>(&v0, v1, v3, arg1);
        0x2::display::update_version<FinaleBadge>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<FinaleBadge>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = FinaleRegistry{
            id               : 0x2::object::new(arg1),
            version          : 1,
            paused           : false,
            minted           : 0x2::table::new<address, bool>(arg1),
            total_minted     : 0,
            authority_pubkey : 0x1::vector::empty<u8>(),
            used_nonces      : 0x2::table::new<u64, bool>(arg1),
        };
        0x2::transfer::share_object<FinaleRegistry>(v6);
    }

    public fun inscription(arg0: &FinaleBadge) : &0x1::string::String {
        &arg0.inscription
    }

    public fun is_first_chronicler(arg0: &FinaleBadge) : bool {
        arg0.is_first_chronicler
    }

    public fun is_paused(arg0: &FinaleRegistry) : bool {
        arg0.paused
    }

    public entry fun migrate(arg0: &0x5760b2685d41bd45e2991dedc242e866b1aca9ff3c3a5e193445751c2b8dfe4b::chronicle::AdminCap, arg1: &mut FinaleRegistry) {
        assert!(arg1.version < 1, 15);
        arg1.version = 1;
    }

    public entry fun mint_finale(arg0: &mut FinaleRegistry, arg1: u8, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_active(arg0);
        assert!(arg1 == 3, 1);
        assert!(arg2 >= 1 && arg2 <= 20, 6);
        assert!(arg5 <= 3, 7);
        let v0 = 0x1::vector::length<u8>(&arg3);
        assert!(v0 > 0, 5);
        assert!(v0 <= 320, 3);
        assert!(0x1::vector::length<u8>(&arg4) <= 200, 4);
        let v1 = 0x2::tx_context::sender(arg10);
        assert!(!0x2::table::contains<address, bool>(&arg0.minted, v1), 2);
        assert!(0x1::vector::length<u8>(&arg0.authority_pubkey) == 32, 8);
        assert!(0x2::clock::timestamp_ms(arg9) <= arg7, 9);
        assert!(!0x2::table::contains<u64, bool>(&arg0.used_nonces, arg6), 10);
        assert!(0x1::vector::length<u8>(&arg8) == 64, 16);
        let v2 = build_voucher_message(0x2::object::id_address<FinaleRegistry>(arg0), v1, arg1, arg2, arg5, arg6, arg7);
        assert!(0x2::ed25519::ed25519_verify(&arg8, &arg0.authority_pubkey, &v2), 11);
        0x2::table::add<u64, bool>(&mut arg0.used_nonces, arg6, true);
        0x2::table::add<address, bool>(&mut arg0.minted, v1, true);
        arg0.total_minted = arg0.total_minted + 1;
        let v3 = arg0.total_minted;
        let v4 = FinaleBadge{
            id                  : 0x2::object::new(arg10),
            battle_id           : arg1,
            hero_id             : arg2,
            title               : 0x1::string::utf8(arg3),
            inscription         : 0x1::string::utf8(arg4),
            rating              : arg5,
            mint_order          : v3,
            is_first_chronicler : v3 == 1,
            mint_timestamp_ms   : 0x2::clock::timestamp_ms(arg9),
            player              : v1,
        };
        let v5 = FinaleBadgeMinted{
            badge_id   : 0x2::object::id<FinaleBadge>(&v4),
            player     : v1,
            mint_order : v3,
            is_first   : v3 == 1,
        };
        0x2::event::emit<FinaleBadgeMinted>(v5);
        0x2::transfer::transfer<FinaleBadge>(v4, v1);
    }

    public fun mint_order(arg0: &FinaleBadge) : u64 {
        arg0.mint_order
    }

    public fun mint_timestamp_ms(arg0: &FinaleBadge) : u64 {
        arg0.mint_timestamp_ms
    }

    public fun player(arg0: &FinaleBadge) : address {
        arg0.player
    }

    public fun rating(arg0: &FinaleBadge) : u8 {
        arg0.rating
    }

    public entry fun set_authority_pubkey(arg0: &0x5760b2685d41bd45e2991dedc242e866b1aca9ff3c3a5e193445751c2b8dfe4b::chronicle::AdminCap, arg1: &mut FinaleRegistry, arg2: vector<u8>) {
        assert!(arg1.version == 1, 13);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 12);
        arg1.authority_pubkey = arg2;
    }

    public entry fun set_paused(arg0: &0x5760b2685d41bd45e2991dedc242e866b1aca9ff3c3a5e193445751c2b8dfe4b::chronicle::AdminCap, arg1: &mut FinaleRegistry, arg2: bool) {
        assert!(arg1.version == 1, 13);
        arg1.paused = arg2;
    }

    public fun title(arg0: &FinaleBadge) : &0x1::string::String {
        &arg0.title
    }

    public fun total_minted(arg0: &FinaleRegistry) : u64 {
        arg0.total_minted
    }

    public fun version(arg0: &FinaleRegistry) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

