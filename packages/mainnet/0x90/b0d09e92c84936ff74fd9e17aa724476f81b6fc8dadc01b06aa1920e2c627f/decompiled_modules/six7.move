module 0x90b0d09e92c84936ff74fd9e17aa724476f81b6fc8dadc01b06aa1920e2c627f::six7 {
    struct SIX7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIX7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIX7>(arg0, 6, b"Six7", b"6 7 ", b"6 7", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1763919609200.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIX7>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIX7>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

