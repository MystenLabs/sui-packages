module 0x53202d65e8a0cd251a4f275b1650ec1d38243301bd8c04fc4633ca11a459955d::event {
    struct Location has drop, store {
        address: 0x1::string::String,
    }

    public fun create_event(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x53202d65e8a0cd251a4f275b1650ec1d38243301bd8c04fc4633ca11a459955d::event_config::EventConfig, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) {
        0x53202d65e8a0cd251a4f275b1650ec1d38243301bd8c04fc4633ca11a459955d::event_config::collect_tax(arg7, arg8);
        let v0 = 0x2::tx_context::sender(arg9);
        let (v1, v2) = 0x2::kiosk::new(arg9);
        let v3 = v2;
        let v4 = v1;
        0x2::kiosk::place<0x53202d65e8a0cd251a4f275b1650ec1d38243301bd8c04fc4633ca11a459955d::event_nft::EventNFT>(&mut v4, &v3, 0x53202d65e8a0cd251a4f275b1650ec1d38243301bd8c04fc4633ca11a459955d::event_nft::mint(arg0, arg1, arg2, arg4, arg3, arg5, arg6, v0, arg9));
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, v0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
    }

    // decompiled from Move bytecode v6
}

