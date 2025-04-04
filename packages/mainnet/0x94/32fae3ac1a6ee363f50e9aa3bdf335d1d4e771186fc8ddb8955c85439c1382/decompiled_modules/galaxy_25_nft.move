module 0x9432fae3ac1a6ee363f50e9aa3bdf335d1d4e771186fc8ddb8955c85439c1382::galaxy_25_nft {
    struct GALAXY_25_NFT has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct Galaxy25NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct CollectionInfo has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        display: 0x2::display::Display<Galaxy25NFT>,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<Galaxy25NFT>,
    }

    struct MintCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct MintEvent has copy, drop {
        nft: 0x2::object::ID,
    }

    fun init(arg0: GALAXY_25_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<GALAXY_25_NFT>(arg0, arg1);
        let v2 = 0x2::display::new<Galaxy25NFT>(&v1, arg1);
        0x2::display::add<Galaxy25NFT>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Galaxy25NFT>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Galaxy25NFT>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::update_version<Galaxy25NFT>(&mut v2);
        let (v3, v4) = 0x2::transfer_policy::new<Galaxy25NFT>(&v1, arg1);
        let v5 = v4;
        let v6 = v3;
        0x9432fae3ac1a6ee363f50e9aa3bdf335d1d4e771186fc8ddb8955c85439c1382::royalty_rule::add<Galaxy25NFT>(&mut v6, &v5, 500, 100);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Galaxy25NFT>>(v6);
        let v7 = MintCap<Galaxy25NFT>{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MintCap<Galaxy25NFT>>(v7, v0);
        let v8 = CollectionInfo{
            id         : 0x2::object::new(arg1),
            publisher  : v1,
            display    : v2,
            policy_cap : v5,
        };
        0x2::transfer::public_transfer<CollectionInfo>(v8, v0);
    }

    public entry fun mint_nft(arg0: &MintCap<Galaxy25NFT>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Galaxy25NFT{
            id   : 0x2::object::new(arg3),
            name : arg1,
            url  : arg2,
        };
        let v1 = MintEvent{nft: 0x2::object::id<Galaxy25NFT>(&v0)};
        0x2::event::emit<MintEvent>(v1);
        let (v2, v3) = 0x2::kiosk::new(arg3);
        let v4 = v3;
        let v5 = v2;
        0x2::kiosk::place<Galaxy25NFT>(&mut v5, &v4, v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v4, 0x2::tx_context::sender(arg3));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v5);
    }

    // decompiled from Move bytecode v6
}

