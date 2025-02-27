module 0xbfe7a886dbd54c80188f48e1d3a8ef2a88d2c68d1a4df7153ce415f7f5743049::mystical_code {
    struct MYSTICAL_CODE has drop {
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

    fun init(arg0: MYSTICAL_CODE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MYSTICAL_CODE>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Mystical Code"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"546865204d7973746963616c20436f646520636f6c6c656374696f6e206973206120756e69717565206469676974616c20657870657269656e6365207468617420636f6d62696e657320746865206d79737465727920616e64206d61676963206f6620746563686e6f6c6f677920656d626f6469656420696e2074686520776f726c64206f66204e4654732e2045616368206974656d20696e2074686520636f6c6c656374696f6e206973206e6f74206a757374206120776f726b206f66206172742c2062757420616c736f2061206b657920746f20616e20756e6b6e6f776e20776f726c64207468617420697320636f6e7374616e746c792065766f6c76696e6720616e64207472616e73666f726d696e672e0a4f6e207468652053554920706c6174666f726d2c206f7572207465616d206f70656e732061206e6577206c6576656c206f66206f70706f7274756e6974792c2063686f69636520616e6420636f6e74726f6c20666f722070726f66657373696f6e616c204e465420636f6c6c6563746f72732e2057652073747269766520746f206f6666657220796f7520756e6971756520616e64206c696d697465642065646974696f6e7320746861742077696c6c206e6f74206f6e6c79206265636f6d6520612076616c7561626c65206164646974696f6e20746f20796f757220636f6c6c656374696f6e2c2062757420616c736f206120736f75726365206f6620696e737069726174696f6e20666f722066757475726520737465707320696e2074686520776f726c64206f66206469676974616c206173736574732e0a4a6f696e204d7973746963616c20436f646520616e6420646973636f76657220656e646c65737320686f72697a6f6e73206f6620706f73736962696c69746965732c207768657265206561636820746f6b656e206361727269657320706f77657220616e6420756e697175656e65737321"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"ipfs://bafybeigrwf6wgs7pvdikabdzkrirciwei7ozqpcf24lpjpqs3dkzyzsoyq"));
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
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Nft>(&mut v5, &v4, 1000, 0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Nft>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft>>(v5);
    }

    // decompiled from Move bytecode v6
}

