module 0xa1ff5cf5e32116b489a85fd152ec0399a0f7de6ba813de9d14c7ee8113a46b7a::lsca {
    struct LSCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LSCA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let (v1, v2) = 0x2::coin::create_currency<LSCA>(arg0, v0, b"LSCA", b"LSCA", b"Locked Scallop Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/scallop-io/scallop-decorations-uri/master/img/lSCA.png")), arg1);
        let v3 = v1;
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<LSCA>(&mut v3, 0x2::math::pow(10, v0 + 6), v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LSCA>>(v3, v4);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LSCA>>(v2);
    }

    // decompiled from Move bytecode v6
}

