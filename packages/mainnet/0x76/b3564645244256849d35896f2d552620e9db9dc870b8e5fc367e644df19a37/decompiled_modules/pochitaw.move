module 0x76b3564645244256849d35896f2d552620e9db9dc870b8e5fc367e644df19a37::pochitaw {
    struct POCHITAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: POCHITAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POCHITAW>(arg0, 6, b"POCHITAW", b"POCHITA WIF", b"https://x.com/balltzehk/status/1841509279465128426?s=46", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_19_32_19_43d6498ba9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POCHITAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POCHITAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

