module 0xde0b67e54d5032984bbc18e0c6d6a7f94f4e375458c1e8649e42a739af177609::sendor {
    struct SENDOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENDOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENDOR>(arg0, 6, b"SENDOR", b"Sendor", b"Giga Chad of SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_16_18_03_59_da2778aa1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENDOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENDOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

