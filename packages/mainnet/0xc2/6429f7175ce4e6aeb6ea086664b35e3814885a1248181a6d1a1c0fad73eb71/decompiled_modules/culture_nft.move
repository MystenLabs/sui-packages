module 0xc26429f7175ce4e6aeb6ea086664b35e3814885a1248181a6d1a1c0fad73eb71::culture_nft {
    struct CULTURE_NFT has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct CultureNFT has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        metadata_url: 0x2::url::Url,
    }

    struct ClaimKey has copy, drop, store {
        tier: u64,
        addr: address,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        minted: u64,
        max_supply: u64,
        paused: bool,
        revealed: bool,
        frozen: bool,
        whitelist_start_ms: u64,
        public_open: bool,
    }

    struct Minted has copy, drop {
        token_id: u64,
        minter: address,
        tier: u64,
        object_id: 0x2::object::ID,
    }

    struct Paused has copy, drop {
        paused: bool,
    }

    struct Revealed has copy, drop {
        dummy_field: bool,
    }

    struct Frozen has copy, drop {
        dummy_field: bool,
    }

    struct RootUpdated has copy, drop {
        tier: u64,
    }

    struct PublicPhaseChanged has copy, drop {
        open: bool,
    }

    struct WhitelistScheduled has copy, drop {
        start_ms: u64,
    }

    fun build_image_url(arg0: u64) : 0x2::url::Url {
        let v0 = b"ipfs://";
        0x1::vector::append<u8>(&mut v0, b"bafybeieyjmddbjc2kng4jephpphvckel4yw6qurn7myuv553mtcrnwjodm");
        0x1::vector::push_back<u8>(&mut v0, 47);
        0x1::vector::append<u8>(&mut v0, b"nft");
        let v1 = u64_to_string(arg0);
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v1));
        0x1::vector::append<u8>(&mut v0, b".jpg");
        0x2::url::new_unsafe_from_bytes(v0)
    }

    fun build_metadata_url(arg0: u64) : 0x2::url::Url {
        let v0 = b"ipfs://";
        0x1::vector::append<u8>(&mut v0, b"bafybeibehkr5n543skata3b2z2xzrlbhmi53autvapeagyllhn3dkyx6my");
        0x1::vector::push_back<u8>(&mut v0, 47);
        let v1 = u64_to_string(arg0);
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v1));
        0x1::vector::append<u8>(&mut v0, b".json");
        0x2::url::new_unsafe_from_bytes(v0)
    }

    fun build_name(arg0: u64) : 0x1::string::String {
        let v0 = b"Culture #";
        let v1 = u64_to_string(arg0);
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v1));
        0x1::string::utf8(v0)
    }

    fun bump_claimed(arg0: &mut Collection, arg1: u64, arg2: address) {
        let v0 = ClaimKey{
            tier : arg1,
            addr : arg2,
        };
        0x2::dynamic_field::remove_if_exists<ClaimKey, u64>(&mut arg0.id, v0);
        0x2::dynamic_field::add<ClaimKey, u64>(&mut arg0.id, v0, claimed_by(arg0, arg1, arg2) + 1);
    }

    public fun claimed_by(arg0: &Collection, arg1: u64, arg2: address) : u64 {
        let v0 = ClaimKey{
            tier : arg1,
            addr : arg2,
        };
        if (0x2::dynamic_field::exists_with_type<ClaimKey, u64>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<ClaimKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    public entry fun freeze_collection(arg0: &AdminCap, arg1: &mut Collection) {
        assert!(!arg1.frozen, 8);
        arg1.frozen = true;
        let v0 = Frozen{dummy_field: false};
        0x2::event::emit<Frozen>(v0);
    }

    fun init(arg0: CULTURE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CULTURE_NFT>(arg0, arg1);
        let v1 = Collection{
            id                 : 0x2::object::new(arg1),
            minted             : 0,
            max_supply         : 555,
            paused             : true,
            revealed           : false,
            frozen             : false,
            whitelist_start_ms : 0,
            public_open        : false,
        };
        0x2::transfer::share_object<Collection>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"creator"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://culturesui.xyz"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"Define Culture"));
        let v7 = 0x2::display::new_with_fields<CultureNFT>(&v0, v3, v5, arg1);
        0x2::display::update_version<CultureNFT>(&mut v7);
        0x2::transfer::public_transfer<0x2::display::Display<CultureNFT>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_frozen(arg0: &Collection) : bool {
        arg0.frozen
    }

    public fun is_paused(arg0: &Collection) : bool {
        arg0.paused
    }

    public fun is_public_open(arg0: &Collection) : bool {
        arg0.public_open
    }

    public fun is_reserved(arg0: u64) : bool {
        let v0 = 0;
        let v1 = vector[21, 22, 63, 64, 106, 111, 219, 349, 474, 521];
        while (v0 < 0x1::vector::length<u64>(&v1)) {
            let v2 = vector[21, 22, 63, 64, 106, 111, 219, 349, 474, 521];
            if (*0x1::vector::borrow<u64>(&v2, v0) == arg0) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_revealed(arg0: &Collection) : bool {
        arg0.revealed
    }

    fun make_nft(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : CultureNFT {
        CultureNFT{
            id           : 0x2::object::new(arg1),
            token_id     : arg0,
            name         : build_name(arg0),
            description  : 0x1::string::utf8(x"446566696e652043756c7475726520e28094206120736f7665726569676e206f662074686520636861696e2e204d6574616461746120696d6d757461626c65206f6e20495046532e"),
            image_url    : build_image_url(arg0),
            metadata_url : build_metadata_url(arg0),
        }
    }

    public fun max_supply(arg0: &Collection) : u64 {
        arg0.max_supply
    }

    public entry fun mint(arg0: &mut Collection, arg1: &0x2::clock::Clock, arg2: vector<vector<u8>>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(!arg0.paused, 1);
        assert!(arg5 < 6, 13);
        assert!(arg0.whitelist_start_ms > 0, 12);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 >= tier_window_start(arg0, arg5), 15);
        assert!(v1 < tier_window_end(arg0, arg5), 15);
        assert!(arg0.minted < arg0.max_supply, 2);
        let v2 = root_of(arg0, arg5);
        assert!(verify_whitelist_proof(&v2, &arg2, arg3, whitelist_leaf(v0, arg4)), 3);
        assert!(arg4 >= 1, 4);
        assert!(claimed_by(arg0, arg5, v0) < arg4, 4);
        let v3 = next_available(arg0);
        assert!(v3 <= arg0.max_supply, 2);
        arg0.minted = arg0.minted + 1;
        bump_claimed(arg0, arg5, v0);
        let v4 = make_nft(v3, arg6);
        let v5 = Minted{
            token_id  : v3,
            minter    : v0,
            tier      : arg5,
            object_id : 0x2::object::id<CultureNFT>(&v4),
        };
        0x2::event::emit<Minted>(v5);
        0x2::transfer::public_transfer<CultureNFT>(v4, v0);
    }

    public entry fun mint_public(arg0: &mut Collection, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!arg0.paused, 1);
        let v1 = arg0.whitelist_start_ms > 0 && 0x2::clock::timestamp_ms(arg1) >= public_auto_start_ms(arg0);
        assert!(arg0.public_open || v1, 12);
        assert!(arg0.minted < arg0.max_supply, 2);
        let v2 = next_available(arg0);
        assert!(v2 <= arg0.max_supply, 2);
        arg0.minted = arg0.minted + 1;
        let v3 = make_nft(v2, arg2);
        let v4 = Minted{
            token_id  : v2,
            minter    : v0,
            tier      : 6,
            object_id : 0x2::object::id<CultureNFT>(&v3),
        };
        0x2::event::emit<Minted>(v4);
        0x2::transfer::public_transfer<CultureNFT>(v3, v0);
    }

    public entry fun mint_reserved(arg0: &AdminCap, arg1: &mut Collection, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_reserved(arg3), 9);
        assert!(arg3 <= arg1.max_supply, 11);
        assert!(arg1.minted < arg1.max_supply, 2);
        assert!(!0x2::dynamic_field::exists_with_type<u64, bool>(&arg1.id, arg3), 10);
        0x2::dynamic_field::add<u64, bool>(&mut arg1.id, arg3, true);
        arg1.minted = arg1.minted + 1;
        let v0 = make_nft(arg3, arg4);
        let v1 = Minted{
            token_id  : arg3,
            minter    : arg2,
            tier      : 6 + 1,
            object_id : 0x2::object::id<CultureNFT>(&v0),
        };
        0x2::event::emit<Minted>(v1);
        0x2::transfer::public_transfer<CultureNFT>(v0, arg2);
    }

    public fun minted(arg0: &Collection) : u64 {
        arg0.minted
    }

    fun next_available(arg0: &Collection) : u64 {
        let v0 = arg0.minted + 1;
        while (is_reserved(v0)) {
            v0 = v0 + 1;
        };
        v0
    }

    public fun public_auto_start_ms(arg0: &Collection) : u64 {
        arg0.whitelist_start_ms + 6 * 1800000
    }

    public fun remaining(arg0: &Collection) : u64 {
        arg0.max_supply - arg0.minted
    }

    public entry fun reveal(arg0: &AdminCap, arg1: &mut Collection) {
        assert!(!arg1.revealed, 7);
        arg1.revealed = true;
        let v0 = Revealed{dummy_field: false};
        0x2::event::emit<Revealed>(v0);
    }

    fun root_of(arg0: &Collection, arg1: u64) : vector<u8> {
        if (0x2::dynamic_field::exists_with_type<u64, vector<u8>>(&arg0.id, arg1)) {
            *0x2::dynamic_field::borrow<u64, vector<u8>>(&arg0.id, arg1)
        } else {
            b""
        }
    }

    public entry fun schedule_whitelist(arg0: &AdminCap, arg1: &mut Collection, arg2: u64) {
        assert!(!arg1.frozen, 8);
        arg1.whitelist_start_ms = arg2;
        let v0 = WhitelistScheduled{start_ms: arg2};
        0x2::event::emit<WhitelistScheduled>(v0);
    }

    public entry fun set_merkle_root(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: vector<u8>) {
        assert!(!arg1.frozen, 8);
        assert!(arg2 < 6, 13);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 5);
        0x2::dynamic_field::remove_if_exists<u64, vector<u8>>(&mut arg1.id, arg2);
        0x2::dynamic_field::add<u64, vector<u8>>(&mut arg1.id, arg2, arg3);
        let v0 = RootUpdated{tier: arg2};
        0x2::event::emit<RootUpdated>(v0);
    }

    public entry fun set_paused(arg0: &AdminCap, arg1: &mut Collection, arg2: bool) {
        assert!(!arg1.frozen, 8);
        arg1.paused = arg2;
        let v0 = Paused{paused: arg2};
        0x2::event::emit<Paused>(v0);
    }

    public entry fun set_public_open(arg0: &AdminCap, arg1: &mut Collection, arg2: bool) {
        assert!(!arg1.frozen, 8);
        arg1.public_open = arg2;
        let v0 = PublicPhaseChanged{open: arg2};
        0x2::event::emit<PublicPhaseChanged>(v0);
    }

    public fun tier_window_end(arg0: &Collection, arg1: u64) : u64 {
        arg0.whitelist_start_ms + (arg1 + 1) * 1800000
    }

    public fun tier_window_start(arg0: &Collection, arg1: u64) : u64 {
        arg0.whitelist_start_ms + arg1 * 1800000
    }

    public fun token_id(arg0: &CultureNFT) : u64 {
        arg0.token_id
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun verify_whitelist_proof(arg0: &vector<u8>, arg1: &vector<vector<u8>>, arg2: u64, arg3: vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg0) == 0) {
            return false
        };
        let v0 = arg3;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg1)) {
            if (arg2 & 1 == 0) {
                let v2 = v0;
                0x1::vector::append<u8>(&mut v2, *0x1::vector::borrow<vector<u8>>(arg1, v1));
                v0 = 0x2::hash::keccak256(&v2);
            } else {
                let v3 = *0x1::vector::borrow<vector<u8>>(arg1, v1);
                0x1::vector::append<u8>(&mut v3, v0);
                v0 = 0x2::hash::keccak256(&v3);
            };
            arg2 = arg2 >> 1;
            v1 = v1 + 1;
        };
        v0 == *arg0
    }

    public fun whitelist_leaf(arg0: address, arg1: u64) : vector<u8> {
        let v0 = 0x2::address::to_bytes(arg0);
        let v1 = b"";
        let v2 = 0;
        while (v2 < 8) {
            0x1::vector::push_back<u8>(&mut v1, ((arg1 >> 56) as u8));
            arg1 = arg1 << 8;
            v2 = v2 + 1;
        };
        0x1::vector::append<u8>(&mut v0, v1);
        0x2::hash::keccak256(&v0)
    }

    public fun whitelist_start_ms(arg0: &Collection) : u64 {
        arg0.whitelist_start_ms
    }

    // decompiled from Move bytecode v7
}

