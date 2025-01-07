module 0x526f777dabb81af3654abdb31baf43668a71bfba3961414cc7f8b5699493540e::ladys {
    struct LADYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LADYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LADYS>(arg0, 6, b"LADYS", b"SUI MILADYS", b"MILDAYS BROUGHT TO SUI BLOCKCHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://artbreederpublic-shortlived.s3.amazonaws.com/30d/imgs/ad3e109c32d14064b1266590.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LADYS>(&mut v2, 42069420000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LADYS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LADYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

