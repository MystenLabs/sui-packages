module 0x1f23375b89ed078ecb565d84e731d0ca4481f8798e229961938a120cf02ac19::barron {
    struct BARRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BARRON>(arg0, 6, b"BARRON", b"BARRON MEME by SuiAI", b"https://x.com/juzybits/status/1881097523932307600", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1737496266598_934fdd032a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BARRON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARRON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

