module 0x3fc9ba5c0f082228d293ba8fd0aa254d9ad034fc214b7280424d48ecd7797f43::bobs {
    struct BOBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBS>(arg0, 6, b"BOBS", b"Bob The Blob", b"My Name is Robert but you can call me Bob", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BOB_THE_BLOB_e8bc53dbe6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

