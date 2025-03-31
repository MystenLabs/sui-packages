module 0xe2d56a014ef4d2b56489568bf2e7121c509dabd1c8917d605032c1aee88a16ec::fm_nft {
    struct FMNFT has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        ipfs_hash: 0x1::string::String,
        content_type: 0x1::string::String,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        ipfs_hash: 0x1::string::String,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
        minted: bool,
    }

    public fun get_details(arg0: &FMNFT) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x1::string::String) {
        (arg0.name, arg0.description, arg0.ipfs_hash, arg0.content_type)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap{
            id     : 0x2::object::new(arg0),
            minted : false,
        };
        0x2::transfer::transfer<MintCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun mint(arg0: &mut MintCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.minted, 0);
        let v0 = b"Qm";
        let v1 = if (starts_with(&arg3, &v0)) {
            true
        } else {
            let v2 = b"bafy";
            starts_with(&arg3, &v2)
        };
        assert!(v1, 1);
        let v3 = FMNFT{
            id           : 0x2::object::new(arg5),
            name         : 0x1::string::utf8(arg1),
            description  : 0x1::string::utf8(arg2),
            ipfs_hash    : 0x1::string::utf8(arg3),
            content_type : 0x1::string::utf8(arg4),
        };
        arg0.minted = true;
        let v4 = MintEvent{
            nft_id      : 0x2::object::id<FMNFT>(&v3),
            name        : v3.name,
            description : v3.description,
            ipfs_hash   : v3.ipfs_hash,
        };
        0x2::event::emit<MintEvent>(v4);
        0x2::transfer::transfer<FMNFT>(v3, 0x2::tx_context::sender(arg5));
    }

    fun starts_with(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg1);
        if (0x1::vector::length<u8>(arg0) < v0) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    // decompiled from Move bytecode v6
}

