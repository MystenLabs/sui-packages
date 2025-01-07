module 0x5f1fb34e08ec2f2ecaa0e7ac6ce81b479c072f0d8a0f7e87228d962bb99ed36a::jkhg {
    struct JKHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JKHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JKHG>(arg0, 9, b"JKHG", b"ASDAS", b"VBCCD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/31043250-3d4a-48d1-be53-5bf490d5e058.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JKHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JKHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

