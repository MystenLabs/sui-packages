module 0x7753e80a067980f61a6d376eda3f62860effb20715008709f5c41d21843441cd::waff {
    struct WAFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAFF>(arg0, 6, b"WAFF", b"Waffle", b"The First Onchain Waffle Generated By AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/portal_eba5ebf0cd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

