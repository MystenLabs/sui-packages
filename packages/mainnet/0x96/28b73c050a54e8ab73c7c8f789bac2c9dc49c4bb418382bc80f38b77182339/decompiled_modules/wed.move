module 0x9628b73c050a54e8ab73c7c8f789bac2c9dc49c4bb418382bc80f38b77182339::wed {
    struct WED has drop {
        dummy_field: bool,
    }

    fun init(arg0: WED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WED>(arg0, 9, b"WED", b"WEWEPUMPS", b"Wewepumps", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/80c33cbb-3aa7-4ca2-b012-922e7da19500.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WED>>(v1);
    }

    // decompiled from Move bytecode v6
}

