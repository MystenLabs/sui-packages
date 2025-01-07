module 0x18333b26e5aeed54dbf9b9b0a786f33442425dcf5d9758d4001550d38749e61f::rayden {
    struct RAYDEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAYDEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAYDEN>(arg0, 6, b"RAYDEN", b"Rayden on SUI", x"52617964656e206f6e205355490a5768792057616c6b205768656e20596f752043616e20476c6964653f20476f2052617964656e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3509_02aa76e16e.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAYDEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAYDEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

