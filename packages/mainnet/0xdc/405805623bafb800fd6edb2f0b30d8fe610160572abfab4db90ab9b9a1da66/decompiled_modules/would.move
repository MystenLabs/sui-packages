module 0xdc405805623bafb800fd6edb2f0b30d8fe610160572abfab4db90ab9b9a1da66::would {
    struct WOULD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOULD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOULD>(arg0, 6, b"WOULD", b"WOULD SUI", b"I love this meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_ae_a_20241124111824_ecb33bbc94.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOULD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOULD>>(v1);
    }

    // decompiled from Move bytecode v6
}

