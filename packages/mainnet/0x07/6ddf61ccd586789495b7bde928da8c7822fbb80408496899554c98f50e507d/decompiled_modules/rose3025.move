module 0x76ddf61ccd586789495b7bde928da8c7822fbb80408496899554c98f50e507d::rose3025 {
    struct ROSE3025 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSE3025, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSE3025>(arg0, 9, b"ROSE3025", b"ROSE", b"LOVE ROSE=TAKE ROSE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d27e0d14-93ca-4eb8-8e7f-eef66ee5d3a2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSE3025>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROSE3025>>(v1);
    }

    // decompiled from Move bytecode v6
}

