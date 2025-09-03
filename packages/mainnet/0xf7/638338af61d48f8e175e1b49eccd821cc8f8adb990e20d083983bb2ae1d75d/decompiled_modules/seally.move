module 0xf7638338af61d48f8e175e1b49eccd821cc8f8adb990e20d083983bb2ae1d75d::seally {
    struct SEALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEALLY>(arg0, 9, b"SEALLY", b"SEALLY", b"Seal is now live on Mainnet $SEALLY coin this moment at Blastdotfun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SEALLY>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEALLY>>(v2, @0x46c2c103ace6092b44f27f9e689df74c62093eb3c4a5f47df909402dba026cc4);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEALLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

