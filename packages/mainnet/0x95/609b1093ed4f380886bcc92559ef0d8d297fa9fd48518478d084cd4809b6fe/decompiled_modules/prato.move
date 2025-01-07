module 0x95609b1093ed4f380886bcc92559ef0d8d297fa9fd48518478d084cd4809b6fe::prato {
    struct PRATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRATO>(arg0, 6, b"PRATO", b"Prato the Sharpei", b"Prato the Sharpei, aim to support chinese sharpeis", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731993941630.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRATO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRATO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

