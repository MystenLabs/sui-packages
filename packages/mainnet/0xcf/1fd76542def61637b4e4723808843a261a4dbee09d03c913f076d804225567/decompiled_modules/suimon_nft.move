module 0xcf1fd76542def61637b4e4723808843a261a4dbee09d03c913f076d804225567::suimon_nft {
    struct SUIMON_NFT has drop {
        dummy_field: bool,
    }

    struct SuimonNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        token_id: u64,
        description: 0x1::string::String,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
        next_id: u64,
        treasury: address,
    }

    fun init(arg0: SUIMON_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUIMON_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<SuimonNFT>(&v0, arg1);
        0x2::display::add<SuimonNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<SuimonNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<SuimonNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<SuimonNFT>(&mut v1, 0x1::string::utf8(b"token_id"), 0x1::string::utf8(b"{token_id}"));
        0x2::display::update_version<SuimonNFT>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<SuimonNFT>(&v0, arg1);
        let v4 = MintCap{
            id       : 0x2::object::new(arg1),
            next_id  : 1,
            treasury : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<MintCap>(v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<SuimonNFT>>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<SuimonNFT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuimonNFT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut MintCap, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 100000000, 0);
        assert!(arg0.next_id <= 666, 1);
        let v0 = SuimonNFT{
            id          : 0x2::object::new(arg5),
            name        : 0x1::string::utf8(arg2),
            image_url   : 0x1::string::utf8(arg3),
            token_id    : arg0.next_id,
            description : 0x1::string::utf8(arg4),
        };
        arg0.next_id = arg0.next_id + 1;
        0x2::transfer::public_transfer<SuimonNFT>(v0, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury);
    }

    public entry fun mint_to_kiosk(arg0: &mut MintCap, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 100000000, 0);
        assert!(arg0.next_id <= 666, 1);
        let v0 = SuimonNFT{
            id          : 0x2::object::new(arg7),
            name        : 0x1::string::utf8(arg2),
            image_url   : 0x1::string::utf8(arg3),
            token_id    : arg0.next_id,
            description : 0x1::string::utf8(arg4),
        };
        arg0.next_id = arg0.next_id + 1;
        0x2::kiosk::place<SuimonNFT>(arg5, arg6, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury);
    }

    // decompiled from Move bytecode v7
}

