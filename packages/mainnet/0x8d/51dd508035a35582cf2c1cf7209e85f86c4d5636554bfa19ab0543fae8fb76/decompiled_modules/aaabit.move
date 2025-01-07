module 0x8d51dd508035a35582cf2c1cf7209e85f86c4d5636554bfa19ab0543fae8fb76::aaabit {
    struct AAABIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAABIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAABIT>(arg0, 6, b"AAABIT", b"RABBIT", x"244141414249542c206a7573742061207261626269740a0a68747470733a2f2f782e636f6d2f6161617261626269746f6e7375690a0a68747470733a2f2f742e6d652f616161726162626974", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_image_6_a54583e30a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAABIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAABIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

