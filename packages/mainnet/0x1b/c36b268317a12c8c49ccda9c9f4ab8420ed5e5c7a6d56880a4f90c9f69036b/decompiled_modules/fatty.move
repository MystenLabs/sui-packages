module 0x1bc36b268317a12c8c49ccda9c9f4ab8420ed5e5c7a6d56880a4f90c9f69036b::fatty {
    struct FATTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FATTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FATTY>(arg0, 6, b"Fatty", b"Fish oil", b"More than a fish a murloc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000149207_cff81ac92f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FATTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FATTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

