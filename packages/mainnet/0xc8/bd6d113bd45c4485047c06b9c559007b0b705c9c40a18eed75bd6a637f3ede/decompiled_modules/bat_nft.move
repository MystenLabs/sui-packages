module 0xc8bd6d113bd45c4485047c06b9c559007b0b705c9c40a18eed75bd6a637f3ede::bat_nft {
    struct BAT_NFT has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct BatmanNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct CollectionInfo has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        display: 0x2::display::Display<BatmanNFT>,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<BatmanNFT>,
    }

    struct MintCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct MintEvent has copy, drop {
        nft: 0x2::object::ID,
    }

    fun init(arg0: BAT_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<BAT_NFT>(arg0, arg1);
        let v2 = 0x2::display::new<BatmanNFT>(&v1, arg1);
        0x2::display::add<BatmanNFT>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<BatmanNFT>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<BatmanNFT>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::update_version<BatmanNFT>(&mut v2);
        let (v3, v4) = 0x2::transfer_policy::new<BatmanNFT>(&v1, arg1);
        let v5 = v4;
        let v6 = v3;
        0xc8bd6d113bd45c4485047c06b9c559007b0b705c9c40a18eed75bd6a637f3ede::royalty_rule::add<BatmanNFT>(&mut v6, &v5, 500, 100);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<BatmanNFT>>(v6);
        let v7 = MintCap<BatmanNFT>{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MintCap<BatmanNFT>>(v7, v0);
        let v8 = CollectionInfo{
            id         : 0x2::object::new(arg1),
            publisher  : v1,
            display    : v2,
            policy_cap : v5,
        };
        0x2::transfer::public_transfer<CollectionInfo>(v8, v0);
    }

    public entry fun mint_nft(arg0: &MintCap<BatmanNFT>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = BatmanNFT{
            id          : 0x2::object::new(arg4),
            name        : arg1,
            description : arg2,
            url         : arg3,
        };
        let v1 = MintEvent{nft: 0x2::object::id<BatmanNFT>(&v0)};
        0x2::event::emit<MintEvent>(v1);
        let (v2, v3) = 0x2::kiosk::new(arg4);
        let v4 = v3;
        let v5 = v2;
        0x2::kiosk::place<BatmanNFT>(&mut v5, &v4, v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v4, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v5);
    }

    // decompiled from Move bytecode v6
}

