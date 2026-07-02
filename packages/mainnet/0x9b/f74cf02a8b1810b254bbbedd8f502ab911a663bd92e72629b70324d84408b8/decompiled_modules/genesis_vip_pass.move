module 0x9bf74cf02a8b1810b254bbbedd8f502ab911a663bd92e72629b70324d84408b8::genesis_vip_pass {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintRegistry has key {
        id: 0x2::object::UID,
        total_minted: u64,
        is_open: bool,
    }

    struct GenesisVIPPass has store, key {
        id: 0x2::object::UID,
        serial: u64,
        tier: u8,
        tier_name: 0x1::string::String,
        minted_at: u64,
        image_url: 0x2::url::Url,
    }

    public entry fun admin_airdrop(arg0: &AdminCap, arg1: &mut MintRegistry, arg2: u8, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.total_minted < 1000, 1);
        let v0 = if (arg2 == 1) {
            true
        } else if (arg2 == 2) {
            true
        } else {
            arg2 == 3
        };
        assert!(v0, 3);
        arg1.total_minted = arg1.total_minted + 1;
        let v1 = GenesisVIPPass{
            id        : 0x2::object::new(arg4),
            serial    : arg1.total_minted,
            tier      : arg2,
            tier_name : tier_label(arg2),
            minted_at : 0x2::tx_context::epoch(arg4),
            image_url : 0x2::url::new_unsafe_from_bytes(b"https://misomosa.gg/nft/genesis-vip-pass.png"),
        };
        0x2::transfer::public_transfer<GenesisVIPPass>(v1, arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = MintRegistry{
            id           : 0x2::object::new(arg0),
            total_minted : 0,
            is_open      : true,
        };
        0x2::transfer::share_object<MintRegistry>(v1);
    }

    public entry fun mint(arg0: &mut MintRegistry, arg1: u8, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_open, 4);
        assert!(arg0.total_minted < 1000, 1);
        let v0 = if (arg1 == 1) {
            true
        } else if (arg1 == 2) {
            true
        } else {
            arg1 == 3
        };
        assert!(v0, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= 5000000000, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 5000000000, arg3), @0xb735145d8976ab7b26e868a88c2d789dbda9b5ace13e956889a7d03c1927fcf0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg3));
        arg0.total_minted = arg0.total_minted + 1;
        let v1 = GenesisVIPPass{
            id        : 0x2::object::new(arg3),
            serial    : arg0.total_minted,
            tier      : arg1,
            tier_name : tier_label(arg1),
            minted_at : 0x2::tx_context::epoch(arg3),
            image_url : 0x2::url::new_unsafe_from_bytes(b"https://misomosa.gg/nft/genesis-vip-pass.png"),
        };
        0x2::transfer::public_transfer<GenesisVIPPass>(v1, 0x2::tx_context::sender(arg3));
    }

    public entry fun set_open(arg0: &AdminCap, arg1: &mut MintRegistry, arg2: bool) {
        arg1.is_open = arg2;
    }

    fun tier_label(arg0: u8) : 0x1::string::String {
        if (arg0 == 3) {
            0x1::string::utf8(b"Gold")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Silver")
        } else {
            0x1::string::utf8(b"Bronze")
        }
    }

    // decompiled from Move bytecode v7
}

