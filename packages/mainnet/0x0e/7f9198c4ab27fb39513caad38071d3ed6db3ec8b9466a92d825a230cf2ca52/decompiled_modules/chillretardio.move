module 0xe7f9198c4ab27fb39513caad38071d3ed6db3ec8b9466a92d825a230cf2ca52::chillretardio {
    struct CHILLRETARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLRETARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLRETARDIO>(arg0, 6, b"CHILLRETARDIO", b"Just a chill retardio", b"Real Retardio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7200_c297c67dc9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLRETARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLRETARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

