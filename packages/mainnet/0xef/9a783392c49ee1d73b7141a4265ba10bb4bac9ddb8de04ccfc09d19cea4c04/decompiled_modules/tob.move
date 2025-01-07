module 0xef9a783392c49ee1d73b7141a4265ba10bb4bac9ddb8de04ccfc09d19cea4c04::tob {
    struct TOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOB>(arg0, 6, b"TOB", b"Trump The Blob", b"Trump The Blob (TOB)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_03_27_21_08a0baf85e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

