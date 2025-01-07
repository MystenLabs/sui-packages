module 0xd4c67010a05c8fe9653c7a1ec0fcf7d99cb3066851ce82599ac445c898f5f8e6::gur {
    struct GUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUR>(arg0, 6, b"GUR", b"TEST", b"JUST A TEST TO STOLE THE BOTS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BOTABOT_02_NVML_18_1200x1200_3358436438_f6a80052b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

