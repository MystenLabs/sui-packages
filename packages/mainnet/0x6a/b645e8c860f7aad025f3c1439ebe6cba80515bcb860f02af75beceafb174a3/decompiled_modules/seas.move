module 0x6ab645e8c860f7aad025f3c1439ebe6cba80515bcb860f02af75beceafb174a3::seas {
    struct SEAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAS>(arg0, 5, b"SEAS", b"Seashell", b"It's just a Seashell...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/5BgdNF7/ssss.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SEAS>(&mut v2, 4700000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

