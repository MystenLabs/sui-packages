module 0x15e09e036eb01648579d66cec3d60c8d33c2383ecb4874640d52ff7dd6913f10::suirihno {
    struct SUIRIHNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRIHNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRIHNO>(arg0, 6, b"SuiRihno", b"Sui Rihno", b" SuiRihno - The strongest meme coin on the Sui blockchain!  Charging forward with fast, low-fee transactions and a community as tough as a rhino. $SUIRHINO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003064_6a1f707b83.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRIHNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRIHNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

