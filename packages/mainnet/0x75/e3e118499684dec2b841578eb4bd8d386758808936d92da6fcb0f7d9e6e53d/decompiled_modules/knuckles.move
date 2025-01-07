module 0x75e3e118499684dec2b841578eb4bd8d386758808936d92da6fcb0f7d9e6e53d::knuckles {
    struct KNUCKLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNUCKLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNUCKLES>(arg0, 6, b"KNUCKLES", b"SuiKnuckles", b"The right way is on", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001063_eaf6a1ec6a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNUCKLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KNUCKLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

