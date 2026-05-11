module 0x181b5b3dbfd3f8bd098e2779b1ef63d3e6e56b0675f27a912023bef210c9b0af::slt234 {
    struct SLT234 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLT234, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://plus.unsplash.com/premium_photo-1778285994438-0549ec7d81e6?q=80&w=774&auto=format&fit=crop";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<SLT234>(arg0, 6, b"SLT234", b"SUILab Test Token 234", b"A test token for SUILab bonding curve integration", v1, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLT234>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLT234>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

