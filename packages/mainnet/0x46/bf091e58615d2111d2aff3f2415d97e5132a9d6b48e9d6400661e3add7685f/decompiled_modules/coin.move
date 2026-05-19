module 0x46bf091e58615d2111d2aff3f2415d97e5132a9d6b48e9d6400661e3add7685f::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN>(arg0, 9, b"DEGEN", b"Degen Coin", x"54686520636f696e2773206f776e2070726f6d6f20746872656164207370696e732061206e61727261746976652061626f75742061206d79737465727920426974636f696e204f472066726f6d205361746f7368692773206f726967696e616c203237302d706572736f6e2077686974657061706572206d61696c696e67206c69737420616e64206120636f6e636570742063616c6c6564207468652022446567656e204c617965722e22205472616465727320617265206170706172656e746c7920627579696e6720697420616e797761792e0a0a4465736372697074696f6e0a0a4120436f696e20466f7220446567656e6572617465732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.pump.fun/coin-image/FmjijgwEHpe32VPvHy1s7u7TLthh9yu1j75djVbWpump?variant=86x86&ipfs=bafybeiduguwolprxuyfsajoldz5uatts3kbfkb5b5xbtncuod6byjpmzjq&src=https%3A%2F%2Fipfs.io%2Fipfs%2Fbafybeiduguwolprxuyfsajoldz5uatts3kbfkb5b5xbtncuod6byjpmzjq")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<COIN>>(0x2::coin::mint<COIN>(&mut v2, 21000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

