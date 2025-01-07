module 0xc2147f462f2f5e7a5aed7f99a895319d5dde5cd4f62fa0bcf01354ce053d8819::wap {
    struct WAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAP>(arg0, 6, b"WAP", b"Wet Ass Pussy", b"We are the WAP of the Water chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6648_15be05a540.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

