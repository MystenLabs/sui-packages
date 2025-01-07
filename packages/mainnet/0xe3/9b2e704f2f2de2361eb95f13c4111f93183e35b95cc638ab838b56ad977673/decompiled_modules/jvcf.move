module 0xe39b2e704f2f2de2361eb95f13c4111f93183e35b95cc638ab838b56ad977673::jvcf {
    struct JVCF has drop {
        dummy_field: bool,
    }

    fun init(arg0: JVCF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JVCF>(arg0, 9, b"JVCF", b"Jvc", b"Jbnggg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2c46a77-23f9-4ef4-b3b2-bf207014efc2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JVCF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JVCF>>(v1);
    }

    // decompiled from Move bytecode v6
}

