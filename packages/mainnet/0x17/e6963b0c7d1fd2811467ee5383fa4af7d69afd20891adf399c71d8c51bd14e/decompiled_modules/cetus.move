module 0x17e6963b0c7d1fd2811467ee5383fa4af7d69afd20891adf399c71d8c51bd14e::cetus {
    struct CETUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CETUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CETUS>(arg0, 9, b"CETUS", b"Cetus Protocol", b"CETUS is the native token of Cetus Protocol.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/Cetus_fd3e9a7dbd.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CETUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CETUS>>(0x2::coin::mint<CETUS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CETUS>>(v2);
    }

    // decompiled from Move bytecode v6
}

