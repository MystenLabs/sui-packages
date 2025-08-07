module 0xf5878c2eaf20a064a4b94bcd7f211297da93fd17af93998e3705784bca8321cd::dizzy {
    struct DIZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIZZY>(arg0, 6, b"DIZZY", b"Dizzy", b"I went to vertigo and all I got was dizzy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1754536005967.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIZZY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIZZY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

