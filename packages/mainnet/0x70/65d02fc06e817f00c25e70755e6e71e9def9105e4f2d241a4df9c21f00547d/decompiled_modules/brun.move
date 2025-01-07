module 0x7065d02fc06e817f00c25e70755e6e71e9def9105e4f2d241a4df9c21f00547d::brun {
    struct BRUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUN>(arg0, 6, b"BRUN", b"Bull Run", b"Lets ride the f-king bull run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731000104292.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

