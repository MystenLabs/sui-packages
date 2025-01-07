module 0xe8fa4debf7f3f6a992eb670b0b173eb7ed269e818758740a8da620f48143eab::pnebs {
    struct PNEBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNEBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNEBS>(arg0, 9, b"PNEBS", b"heje", b"vs w", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fabcf1f7-5d3d-48e1-b90f-3d11edac7217.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNEBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNEBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

