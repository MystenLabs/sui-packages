module 0x6ec2b6b72fa7adabae6ffffcab33398af0ed301d632c6a18c0ab219816694937::ponkito {
    struct PONKITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKITO>(arg0, 9, b"Ponkito", b"Ponkito", b"Just a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PONKITO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKITO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONKITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

