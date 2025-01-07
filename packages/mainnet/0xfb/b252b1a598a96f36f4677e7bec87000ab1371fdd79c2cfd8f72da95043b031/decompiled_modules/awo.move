module 0xfbb252b1a598a96f36f4677e7bec87000ab1371fdd79c2cfd8f72da95043b031::awo {
    struct AWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWO>(arg0, 9, b"AWO", b"Awo cat", b"Start your day with Awo0o0~", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5ffe58dd-5c07-4411-8640-421f7d6fd0c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

