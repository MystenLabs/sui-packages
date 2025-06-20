module 0xb8f73dc8c4bc0e247e9ac9b933f018662aa0ff8e6d95fd4ce34db10981ea9151::beera {
    struct BEERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEERA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEERA>(arg0, 6, b"BEERA", b"Beera Beera", x"2442454552412048652069732074686520626561722e0a486520646f6573206e6f7420726f61722c206865206a7573742076696265732e20416c776179732063616c6d2c20616c7761797320636f6f6c2c206576656e207768656e207468652077686f6c6520636861696e206973206f6e20666972652e2042454552412069732074686520656d626f64696d656e74206f66206c616964206261636b20646f6d696e616e63652e2048652073686f77732075702c2064726f7073206120596f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib5xc2gzoqijcjyxbluqyb3tw3qo2dvirzut25mjutberormwsqta")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEERA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BEERA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

