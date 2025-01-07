module 0xcadd35907cb430c737bb35c66d020c58944689a7b59d27fb9f14ceba518017d9::duckey {
    struct DUCKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCKEY>(arg0, 6, b"DUCKEY", b"DUCK", b"duckey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731971755969.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCKEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCKEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

