module 0x43c7acb6b61a368369e698f549958ad14646ce95693cb02d7d1fda1747873b93::jabu {
    struct JABU has drop {
        dummy_field: bool,
    }

    fun init(arg0: JABU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JABU>(arg0, 6, b"JABU", b"Lord Jabu Jabu", b"only legends know", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1069_23cad95a99.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JABU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JABU>>(v1);
    }

    // decompiled from Move bytecode v6
}

