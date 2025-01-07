module 0x9d986047499373a5ed6164fdf5315c0f436f946bf70176e070379a9983cade99::ashiba {
    struct ASHIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASHIBA>(arg0, 6, b"ASHIBA", b"aaashib", b"AAASHIB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_2615c96972.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASHIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASHIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

