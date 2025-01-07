module 0x3a5e7c6419f864ac9add17a7dac5a9cefa03604162780a1aa9abc6da17ee5ba2::scv {
    struct SCV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCV>(arg0, 6, b"SCV", b"2001SUICIVIC", b"a eman abio used 2001 honda civic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_12_47_27_1b7b3664d6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCV>>(v1);
    }

    // decompiled from Move bytecode v6
}

