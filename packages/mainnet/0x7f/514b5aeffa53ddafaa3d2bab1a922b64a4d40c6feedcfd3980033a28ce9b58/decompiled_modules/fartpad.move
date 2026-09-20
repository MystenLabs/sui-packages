module 0x7f514b5aeffa53ddafaa3d2bab1a922b64a4d40c6feedcfd3980033a28ce9b58::fartpad {
    struct FARTPAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTPAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FARTPAD>(arg0, 6, 0x1::string::utf8(b"FARTPAD"), 0x1::string::utf8(b"FartPad"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://launchdesk.38.242.215.238.sslip.io/assets/47eb6c8f85f7348606436b8d4719af663560dfc2da11ecd8c56169eebd61b8f6.jpg"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTPAD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FARTPAD>>(0x2::coin_registry::finalize<FARTPAD>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

