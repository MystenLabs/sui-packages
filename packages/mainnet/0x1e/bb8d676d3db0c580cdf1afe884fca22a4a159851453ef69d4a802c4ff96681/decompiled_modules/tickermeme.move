module 0x1ebb8d676d3db0c580cdf1afe884fca22a4a159851453ef69d4a802c4ff96681::tickermeme {
    struct TICKERMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKERMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKERMEME>(arg0, 9, b"TICKERMEME", b"memefo", b"asw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bdb2e13b-9cf4-430f-ad57-683bb51bfcde.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKERMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TICKERMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

