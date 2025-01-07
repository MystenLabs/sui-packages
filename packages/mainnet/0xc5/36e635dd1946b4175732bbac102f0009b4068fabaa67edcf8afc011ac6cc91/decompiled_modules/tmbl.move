module 0xc536e635dd1946b4175732bbac102f0009b4068fabaa67edcf8afc011ac6cc91::tmbl {
    struct TMBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TMBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TMBL>(arg0, 9, b"TMBL", b"TEAM BULL", b"Team for the Bull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9f043970-eca9-4ad3-a925-f5aadd9da3a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TMBL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TMBL>>(v1);
    }

    // decompiled from Move bytecode v6
}

