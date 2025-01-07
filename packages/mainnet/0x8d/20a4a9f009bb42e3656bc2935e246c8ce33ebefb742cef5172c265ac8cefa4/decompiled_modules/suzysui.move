module 0x8d20a4a9f009bb42e3656bc2935e246c8ce33ebefb742cef5172c265ac8cefa4::suzysui {
    struct SUZYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUZYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUZYSUI>(arg0, 6, b"SUZYSUI", b"SUIzy Seahorse", b" Ridin the waves of the Sui chain, Dive in and ride the tide with the swiftest sea horse of the sea, Suzy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_12_00_53_46_5922edf5fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUZYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUZYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

