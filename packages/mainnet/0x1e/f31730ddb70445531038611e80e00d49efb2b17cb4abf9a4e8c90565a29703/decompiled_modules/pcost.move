module 0x1ef31730ddb70445531038611e80e00d49efb2b17cb4abf9a4e8c90565a29703::pcost {
    struct PCOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCOST>(arg0, 6, b"PCOST", b"Pepecoinonsuiturbos", b"The most memeable memecoin in existence ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730982521011.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PCOST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCOST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

