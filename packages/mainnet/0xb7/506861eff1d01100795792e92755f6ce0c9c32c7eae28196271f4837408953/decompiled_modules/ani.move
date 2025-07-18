module 0xb7506861eff1d01100795792e92755f6ce0c9c32c7eae28196271f4837408953::ani {
    struct ANI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ANI>(arg0, 6, b"ANI", b"Ani Grok Companion", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/7660573a93ae1fe0e05d0c20ed4acdf2_f01e7ab3e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

