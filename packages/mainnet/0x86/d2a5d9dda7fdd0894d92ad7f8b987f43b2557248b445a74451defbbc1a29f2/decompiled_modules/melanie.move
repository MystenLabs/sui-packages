module 0x86d2a5d9dda7fdd0894d92ad7f8b987f43b2557248b445a74451defbbc1a29f2::melanie {
    struct MELANIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MELANIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MELANIE>(arg0, 9, b"Melanie", b"Melanie Trump", b"Melanie trump on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/abb914b7690ffa99f3647f22b36ed183blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MELANIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MELANIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

