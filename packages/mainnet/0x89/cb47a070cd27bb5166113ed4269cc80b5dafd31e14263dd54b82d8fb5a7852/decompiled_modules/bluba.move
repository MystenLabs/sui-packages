module 0x89cb47a070cd27bb5166113ed4269cc80b5dafd31e14263dd54b82d8fb5a7852::bluba {
    struct BLUBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBA>(arg0, 6, b"BLUBA", b"Bluba", x"426c7562612c20426c7562277320776966650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731002305105.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

