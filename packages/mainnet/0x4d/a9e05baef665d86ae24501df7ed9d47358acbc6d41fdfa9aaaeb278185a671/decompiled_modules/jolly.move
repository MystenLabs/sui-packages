module 0x4da9e05baef665d86ae24501df7ed9d47358acbc6d41fdfa9aaaeb278185a671::jolly {
    struct JOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOLLY>(arg0, 9, b"Jolly", b"Jolly", b"JollyJolly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JOLLY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOLLY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

