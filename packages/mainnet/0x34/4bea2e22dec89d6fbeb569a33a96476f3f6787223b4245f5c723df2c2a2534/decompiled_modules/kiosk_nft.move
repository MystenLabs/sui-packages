module 0x344bea2e22dec89d6fbeb569a33a96476f3f6787223b4245f5c723df2c2a2534::kiosk_nft {
    struct KIOSK_NFT has drop {
        dummy_field: bool,
    }

    struct KioskNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        token_id: u64,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
        next_id: u64,
        treasury: address,
    }

    public fun image_url(arg0: &KioskNFT) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: KIOSK_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<KIOSK_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<KioskNFT>(&v0, arg1);
        0x2::display::add<KioskNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<KioskNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<KioskNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<KioskNFT>(&mut v1, 0x1::string::utf8(b"collection"), 0x1::string::utf8(b"Suimon PFP"));
        0x2::display::add<KioskNFT>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://cutforsuimon.com"));
        0x2::display::update_version<KioskNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<KioskNFT>>(v1, 0x2::tx_context::sender(arg1));
        let (v2, v3) = 0x2::transfer_policy::new<KioskNFT>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<KioskNFT>>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<KioskNFT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v4 = MintCap{
            id       : 0x2::object::new(arg1),
            next_id  : 1,
            treasury : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<MintCap>(v4);
    }

    public entry fun mint(arg0: &mut MintCap, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 100000000, 0);
        assert!(arg0.next_id <= 666, 1);
        let v0 = KioskNFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg2),
            image_url   : 0x1::string::utf8(arg3),
            description : 0x1::string::utf8(arg4),
            token_id    : arg0.next_id,
        };
        arg0.next_id = arg0.next_id + 1;
        0x2::transfer::public_transfer<KioskNFT>(v0, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury);
    }

    public fun name(arg0: &KioskNFT) : 0x1::string::String {
        arg0.name
    }

    public fun token_id(arg0: &KioskNFT) : u64 {
        arg0.token_id
    }

    // decompiled from Move bytecode v7
}

