module 0x8af083eb71affa77382e50fb0c8d4a221d5af03751bae87455ef058848b3f7d::orgo {
    struct ORGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORGO>(arg0, 6, b"ORGO", b"Sui Orgo", b"Ocean gorila sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002048_43153e5731.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

