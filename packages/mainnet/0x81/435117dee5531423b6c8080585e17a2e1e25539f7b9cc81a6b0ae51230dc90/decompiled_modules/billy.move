module 0x81435117dee5531423b6c8080585e17a2e1e25539f7b9cc81a6b0ae51230dc90::billy {
    struct BILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLY>(arg0, 6, b"Billy", b"To Billy", b"Turbos is pioneering a wave of billion dollar tokens on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730952299854.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BILLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

