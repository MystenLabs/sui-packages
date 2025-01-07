module 0xfb6b8d0ef6b07fe078ee4cb5c42bde4ffea0ba0e3c248e504b85f94421833f04::ibo {
    struct IBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: IBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IBO>(arg0, 6, b"IBO", b"I.Bot", b" Less emotions, more profits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3748_8bdbbcab3c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

