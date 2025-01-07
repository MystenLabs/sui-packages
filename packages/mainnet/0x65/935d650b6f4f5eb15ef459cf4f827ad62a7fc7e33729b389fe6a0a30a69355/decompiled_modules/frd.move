module 0x65935d650b6f4f5eb15ef459cf4f827ad62a7fc7e33729b389fe6a0a30a69355::frd {
    struct FRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRD>(arg0, 9, b"FRD", b"Freedurov", b"Launchpad for sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed3907e6-966f-47d7-88ba-2f1c35217271.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

