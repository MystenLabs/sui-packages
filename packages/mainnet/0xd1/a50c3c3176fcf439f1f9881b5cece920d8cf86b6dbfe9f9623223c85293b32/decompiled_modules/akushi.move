module 0xd1a50c3c3176fcf439f1f9881b5cece920d8cf86b6dbfe9f9623223c85293b32::akushi {
    struct AKUSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKUSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKUSHI>(arg0, 6, b"AKUSHI", b"Akushi", b"Dare to look into her eyes, and lose more than your sanity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241130_230040_085_708f456ad6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKUSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKUSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

