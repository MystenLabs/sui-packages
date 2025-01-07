module 0xdc51041663806ad7bd8f2e8635803ee1c46e24cf6bc76771894f2089a65f96a1::rito {
    struct RITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RITO>(arg0, 6, b"RITO", b"Suirito", b"The cheekiest burrito on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Frame_252_de41593159.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

