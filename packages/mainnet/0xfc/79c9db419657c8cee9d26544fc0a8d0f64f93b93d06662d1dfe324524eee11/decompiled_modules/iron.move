module 0xfc79c9db419657c8cee9d26544fc0a8d0f64f93b93d06662d1dfe324524eee11::iron {
    struct IRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRON>(arg0, 9, b"IRON", b"Iron Man", b"The movie that launched the MCU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://m.media-amazon.com/images/M/MV5BMTczNTI2ODUwOF5BMl5BannerXkFtZTcwMTU0NTIzMw@@._V1_.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IRON>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRON>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IRON>>(v1);
    }

    // decompiled from Move bytecode v6
}

