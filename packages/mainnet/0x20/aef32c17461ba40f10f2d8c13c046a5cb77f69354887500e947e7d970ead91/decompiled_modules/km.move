module 0x20aef32c17461ba40f10f2d8c13c046a5cb77f69354887500e947e7d970ead91::km {
    struct KM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KM>(arg0, 9, b"KM", b"kapakmerah", b"Little community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d851cf1-2409-415a-acc5-77357f9d1311.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KM>>(v1);
    }

    // decompiled from Move bytecode v6
}

