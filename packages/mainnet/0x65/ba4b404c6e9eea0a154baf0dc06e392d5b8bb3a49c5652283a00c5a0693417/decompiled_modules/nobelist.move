module 0x65ba4b404c6e9eea0a154baf0dc06e392d5b8bb3a49c5652283a00c5a0693417::nobelist {
    struct NOBELIST has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOBELIST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBELIST>(arg0, 6, b"Nobelist", b"Han Kang", b"dedicate to 2024 Novelist", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013898_7d3ce6060d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBELIST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOBELIST>>(v1);
    }

    // decompiled from Move bytecode v6
}

