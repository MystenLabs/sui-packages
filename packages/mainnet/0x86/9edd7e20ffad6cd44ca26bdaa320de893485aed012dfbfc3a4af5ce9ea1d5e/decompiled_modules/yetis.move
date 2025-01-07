module 0x869edd7e20ffad6cd44ca26bdaa320de893485aed012dfbfc3a4af5ce9ea1d5e::yetis {
    struct YETIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: YETIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YETIS>(arg0, 6, b"YETIS", b"Yetis", b"Climbing to the top of Mt. Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731557799667.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YETIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YETIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

