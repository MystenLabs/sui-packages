module 0xdff4d77c85abd53cb344dd6f73f859ec29cec32c52418fe2d04a9ef3d34bcf36::sab {
    struct SAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAB>(arg0, 6, b"SAB", b"SuiAbout", b"@suilaunchcoin @SuiAIFun @suilaunchcoin  $SAB + SuiAbout https://t.co/bYaFdSsQSq", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/sab-sb50ls.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

