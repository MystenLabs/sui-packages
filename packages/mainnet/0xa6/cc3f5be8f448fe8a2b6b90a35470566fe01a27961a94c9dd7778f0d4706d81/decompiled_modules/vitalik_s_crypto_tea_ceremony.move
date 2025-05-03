module 0xa6cc3f5be8f448fe8a2b6b90a35470566fe01a27961a94c9dd7778f0d4706d81::vitalik_s_crypto_tea_ceremony {
    struct VITALIK_S_CRYPTO_TEA_CEREMONY has drop {
        dummy_field: bool,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        media_url: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public fun mint_edition_nft(arg0: &mut 0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Manager, arg1: &0x2::transfer_policy::TransferPolicy<Nft>, arg2: &0x2::clock::Clock, arg3: &mut 0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Collection, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<0x1::string::String>, arg11: vector<0x1::string::String>, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: vector<u8>, arg17: 0x2::coin::Coin<0x2::sui::SUI>, arg18: &mut 0x2::kiosk::Kiosk, arg19: &0x2::kiosk::KioskOwnerCap, arg20: &mut 0x2::tx_context::TxContext) {
        let v0 = create_nft(arg7, arg8, arg9, arg10, arg11, arg20);
        0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::mint_edition_nft<Nft>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, v0, arg18, arg19, arg20);
    }

    public fun mint_nft(arg0: &0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Manager, arg1: &0x2::transfer_policy::TransferPolicy<Nft>, arg2: &mut 0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Collection, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: vector<u8>, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = create_nft(arg5, arg6, arg7, arg8, arg9, arg15);
        0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::mint_nft<Nft>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, v0, arg15);
    }

    public fun mint_order(arg0: &mut 0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Manager, arg1: &0x2::clock::Clock, arg2: &mut 0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Collection, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) {
        0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::mint_order(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun update_nft(arg0: &mut 0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::Manager, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: vector<u8>, arg8: &mut 0x2::kiosk::Kiosk, arg9: &0x2::kiosk::KioskOwnerCap, arg10: &mut 0x2::tx_context::TxContext) {
        0x1f468aaa1e906c4e7e87c7b4976ccca82693b7bdc51e380ae314b3a681bc0d8b::launchpad::update_nft(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10);
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

    fun init(arg0: VITALIK_S_CRYPTO_TEA_CEREMONY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<VITALIK_S_CRYPTO_TEA_CEREMONY>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Vitalik's Crypto Tea Ceremony"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"5374657020696e746f20612072617265206d6f6d656e74206f662063616c6d207769746820457468657265756de280997320766973696f6e6172792c20566974616c696b204275746572696e2e0a566974616c696be28099732043727970746f2054656120436572656d6f6e792063617074757265732074686520736572656e6520736c757270206f66206272696c6c69616e636520e2809420776865726520626c6f636b636861696e206d65657473206d696e6466756c6e6573732e0a412068616e6463726166746564206c6f6f7020746861742066757365732072697475616c207769746820696e6e6f766174696f6e2c2072656d696e64696e672075732074686174206576656e2063727970746f2067656e6975736573206e656564207468656972207465612074696d652e0a5369702c207265666c6563742c20616e64206f776e2061207069656365206f66207765623320686973746f72792e"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafybeia7w5clwdww7j7hfri3gc7nzyv5jbkh4346tcva6kq74275tjedxq"));
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
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut v5, &v4, 100, 0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nft>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(v5);
    }

    // decompiled from Move bytecode v6
}

