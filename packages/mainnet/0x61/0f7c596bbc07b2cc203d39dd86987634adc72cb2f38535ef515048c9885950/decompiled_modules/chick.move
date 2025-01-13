module 0x610f7c596bbc07b2cc203d39dd86987634adc72cb2f38535ef515048c9885950::chick {
    struct CHICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHICK>(arg0, 6, b"CHICK", b"Wisechick by SuiAI", b"Turning dreams into reality.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000614209_9c34895fbe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHICK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

