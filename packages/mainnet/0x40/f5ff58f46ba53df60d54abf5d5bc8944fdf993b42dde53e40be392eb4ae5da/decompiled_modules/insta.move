module 0x40f5ff58f46ba53df60d54abf5d5bc8944fdf993b42dde53e40be392eb4ae5da::insta {
    struct INSTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: INSTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INSTA>(arg0, 6, b"INSTA", b"insta", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://192.168.1.107:4000/api/images/cd418bd6d53a1decb5a3a9ed6b28581b9888bb556831c7ca418e5282155f5205.png")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INSTA>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<INSTA>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

