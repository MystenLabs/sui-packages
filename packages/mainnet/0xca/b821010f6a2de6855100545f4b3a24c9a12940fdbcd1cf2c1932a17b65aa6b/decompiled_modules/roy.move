module 0xcab821010f6a2de6855100545f4b3a24c9a12940fdbcd1cf2c1932a17b65aa6b::roy {
    struct ROY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROY>(arg0, 9, b"ROY", b"Love", b"Sayangi dirimu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aab6e6a1-b554-4baf-ae38-8c130ccb2c9b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROY>>(v1);
    }

    // decompiled from Move bytecode v6
}

