module 0xcca33cf4ef7efa2555ff8d3340c4a829680c577e311b60dc9fddc80f0e909b99::booth_nft {
    struct BOOTH_NFT has drop {
        dummy_field: bool,
    }

    struct MintConfig has key {
        id: 0x2::object::UID,
        admin: address,
        max_supply: u64,
        minted: u64,
        paused: bool,
    }

    struct BoothNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        animal_trait: 0x1::string::String,
        attributes: 0x1::string::String,
        minter: address,
        mint_number: u64,
    }

    struct MintedEvent has copy, drop {
        minter: address,
        nft_id: 0x2::object::ID,
        mint_number: u64,
    }

    fun assert_admin(arg0: &MintConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
    }

    public entry fun create_mint_config(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 > 0, 5);
        let v0 = MintConfig{
            id         : 0x2::object::new(arg1),
            admin      : 0x2::tx_context::sender(arg1),
            max_supply : arg0,
            minted     : 0,
            paused     : false,
        };
        0x2::transfer::share_object<MintConfig>(v0);
    }

    fun init(arg0: BOOTH_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"animal_trait"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BLOCKBLOCK NFT - 2026 Spring Yonsei Club Fair"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BLOCKBLOCK NFT collection for 2026 Club Fair"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{animal_trait}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{attributes}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://blockblock-club-fair-2026.onrender.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"BlockBlock Booth"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://blockblock-club-fair-2026.onrender.com"));
        let v4 = 0x2::package::claim<BOOTH_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<BoothNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<BoothNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<BoothNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun is_paused(arg0: &MintConfig) : bool {
        arg0.paused
    }

    public fun max_supply(arg0: &MintConfig) : u64 {
        arg0.max_supply
    }

    public entry fun mint(arg0: &mut MintConfig, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(!arg0.paused, 4);
        assert!(arg0.minted < arg0.max_supply, 3);
        arg0.minted = arg0.minted + 1;
        let v1 = BoothNFT{
            id           : 0x2::object::new(arg5),
            name         : arg1,
            image_url    : arg2,
            animal_trait : arg3,
            attributes   : arg4,
            minter       : v0,
            mint_number  : arg0.minted,
        };
        let v2 = MintedEvent{
            minter      : v0,
            nft_id      : 0x2::object::id<BoothNFT>(&v1),
            mint_number : arg0.minted,
        };
        0x2::event::emit<MintedEvent>(v2);
        0x2::transfer::public_transfer<BoothNFT>(v1, v0);
    }

    public fun minted_count(arg0: &MintConfig) : u64 {
        arg0.minted
    }

    public entry fun set_paused(arg0: &mut MintConfig, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        arg0.paused = arg1;
    }

    // decompiled from Move bytecode v6
}

