module 0xc3898f5ab6bfb20d4e2939601ee6623e5c71fb637bf4aae698321ee26a6e0c77::Yup {
    struct YUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUP>(arg0, 9, b"YUP", b"Yup", b"yup yup", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/642e80da-6ad3-467d-a28e-9b475eabefcd.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

