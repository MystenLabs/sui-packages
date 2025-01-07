module 0xf9f183238beaad383fbd19b752018360a654aa307fe674b83c7bde9793a370c8::krabs {
    struct KRABS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRABS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRABS>(arg0, 6, b"KRABS", b"Mr. Krabs", b"Mr. Krabs meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4485_c5750352f2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRABS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRABS>>(v1);
    }

    // decompiled from Move bytecode v6
}

