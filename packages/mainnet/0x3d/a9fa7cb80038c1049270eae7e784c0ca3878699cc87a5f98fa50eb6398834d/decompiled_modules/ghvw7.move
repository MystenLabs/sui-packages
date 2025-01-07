module 0x3da9fa7cb80038c1049270eae7e784c0ca3878699cc87a5f98fa50eb6398834d::ghvw7 {
    struct GHVW7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHVW7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHVW7>(arg0, 9, b"GHVW7", b"Pgvba", b"Bivjaka", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/06f4133f-3901-44fe-b1c5-d3fcf642bcb6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHVW7>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHVW7>>(v1);
    }

    // decompiled from Move bytecode v6
}

