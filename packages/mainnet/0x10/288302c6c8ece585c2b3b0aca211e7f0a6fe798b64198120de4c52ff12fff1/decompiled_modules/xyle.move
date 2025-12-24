module 0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::xyle {
    struct XYLE has drop {
        dummy_field: bool,
    }

    struct XyleTreasuryCap has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<XYLE>,
    }

    fun init(arg0: XYLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<XYLE>(arg0, 9, 0x1::string::utf8(b"XYLE"), 0x1::string::utf8(b"XYLE Protocol"), 0x1::string::utf8(b"Utility token powering the XYLE Protocol."), 0x1::string::utf8(b"https://raw.githubusercontent.com/dappstertools-coder/xyle-token-assets/e6972809f44399eef1399bc6db90293230ff3851/xyle.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XYLE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<XYLE>>(0x2::coin_registry::finalize<XYLE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_xyle(arg0: &mut 0x2::coin::TreasuryCap<XYLE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<XYLE>>(0x2::coin::mint<XYLE>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

