module 0xfeab5c44258482ea3d2ea277f55f19eff32b19f9250940d8610463dfee9acf09::bea {
    struct BEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEA>(arg0, 9, b"BEA", b"Bear ", b"Fantastic coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b75c0aee-48d1-4fd0-9f7f-60d32c8c0464.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

