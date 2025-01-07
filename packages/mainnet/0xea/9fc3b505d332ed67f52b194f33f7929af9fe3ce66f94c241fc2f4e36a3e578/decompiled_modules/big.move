module 0xea9fc3b505d332ed67f52b194f33f7929af9fe3ce66f94c241fc2f4e36a3e578::big {
    struct BIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIG>(arg0, 9, b"BIG", b"biiig", b"MASHROM BIG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/99f55264-a0f2-4d30-821c-232acd911e7c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

