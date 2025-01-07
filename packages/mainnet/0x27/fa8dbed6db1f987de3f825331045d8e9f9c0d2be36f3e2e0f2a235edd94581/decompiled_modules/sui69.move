module 0x27fa8dbed6db1f987de3f825331045d8e9f9c0d2be36f3e2e0f2a235edd94581::sui69 {
    struct SUI69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI69>(arg0, 6, b"SUI69", b"SUI SHITCOIN INDEX", b"Twop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001407_ed8a6de489.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI69>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI69>>(v1);
    }

    // decompiled from Move bytecode v6
}

