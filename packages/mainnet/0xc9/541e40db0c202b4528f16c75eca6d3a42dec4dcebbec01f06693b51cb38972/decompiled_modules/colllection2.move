module 0xc9541e40db0c202b4528f16c75eca6d3a42dec4dcebbec01f06693b51cb38972::colllection2 {
    struct COLLLECTION2 has drop {
        dummy_field: bool,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    entry fun mint_edition_nft(arg0: &mut 0x68321f4b0754f3089604ea90dae48c1a9900a601d18ea8eae5fcc046d147593e::launchpad::Manager, arg1: &0x2::transfer_policy::TransferPolicy<Nft>, arg2: &0x2::clock::Clock, arg3: &mut 0x68321f4b0754f3089604ea90dae48c1a9900a601d18ea8eae5fcc046d147593e::launchpad::Collection, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<0x1::string::String>, arg11: vector<0x1::string::String>, arg12: u64, arg13: u64, arg14: u64, arg15: vector<u8>, arg16: 0x2::coin::Coin<0x2::sui::SUI>, arg17: &mut 0x2::kiosk::Kiosk, arg18: &0x2::kiosk::KioskOwnerCap, arg19: &mut 0x2::tx_context::TxContext) {
        let v0 = create_nft(arg7, arg8, arg9, arg10, arg11, arg19);
        0x68321f4b0754f3089604ea90dae48c1a9900a601d18ea8eae5fcc046d147593e::launchpad::mint_edition_nft<Nft>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, v0, arg17, arg18, arg19);
    }

    entry fun mint_nft(arg0: &0x68321f4b0754f3089604ea90dae48c1a9900a601d18ea8eae5fcc046d147593e::launchpad::Manager, arg1: &0x2::transfer_policy::TransferPolicy<Nft>, arg2: &mut 0x68321f4b0754f3089604ea90dae48c1a9900a601d18ea8eae5fcc046d147593e::launchpad::Collection, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: vector<u8>, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = create_nft(arg5, arg6, arg7, arg8, arg9, arg15);
        0x68321f4b0754f3089604ea90dae48c1a9900a601d18ea8eae5fcc046d147593e::launchpad::mint_nft<Nft>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v0, arg15);
    }

    entry fun mint_order(arg0: &mut 0x68321f4b0754f3089604ea90dae48c1a9900a601d18ea8eae5fcc046d147593e::launchpad::Manager, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x68321f4b0754f3089604ea90dae48c1a9900a601d18ea8eae5fcc046d147593e::launchpad::Collection, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) {
        0x68321f4b0754f3089604ea90dae48c1a9900a601d18ea8eae5fcc046d147593e::launchpad::mint_order(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    entry fun update_nft(arg0: &mut 0x68321f4b0754f3089604ea90dae48c1a9900a601d18ea8eae5fcc046d147593e::launchpad::Manager, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: vector<u8>, arg8: &mut 0x2::kiosk::Kiosk, arg9: &0x2::kiosk::KioskOwnerCap, arg10: &mut 0x2::tx_context::TxContext) {
        0x68321f4b0754f3089604ea90dae48c1a9900a601d18ea8eae5fcc046d147593e::launchpad::update_nft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10);
        let v0 = 0x2::kiosk::borrow_mut<Nft>(arg8, arg9, arg1);
        v0.name = arg2;
        v0.description = arg3;
        v0.media_url = arg4;
        v0.attributes = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg5, arg6);
    }

    fun create_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) : Nft {
        Nft{
            id          : 0x2::object::new(arg5),
            name        : arg0,
            description : arg1,
            media_url   : arg2,
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg3, arg4),
        }
    }

    fun init(arg0: COLLLECTION2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COLLLECTION2>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"colllection2"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"636f6c6c656374696f6e32206465736372697074696f6e0a"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafybeihfaxdxrtabebpwggwrjppl2nnndhjjqva36yljikroma7xpqsnjm"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"media_url"), 0x1::string::utf8(b"{media_url}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<Nft>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<Nft>(&v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Nft>(&mut v5, &v4);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut v5, &v4, 0, 0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nft>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(v5);
    }

    // decompiled from Move bytecode v6
}

