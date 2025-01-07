module 0x7c2e05d280cc4a05053f8fd1e638b62f795436e600baabdbb489cabc0c9cdca7::chritardio {
    struct CHRITARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHRITARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHRITARDIO>(arg0, 6, b"CHRITARDIO", b"Chritardio", b"https://Chritardio.com https://x.com/Chritardio https://t.me/Chritardio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9999999_0963db804d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHRITARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHRITARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

