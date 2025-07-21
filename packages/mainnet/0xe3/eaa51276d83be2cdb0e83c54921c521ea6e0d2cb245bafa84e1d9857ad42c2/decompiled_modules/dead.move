module 0xe3eaa51276d83be2cdb0e83c54921c521ea6e0d2cb245bafa84e1d9857ad42c2::dead {
    struct DEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEAD>(arg0, 6, b"DEAD", b"DEAD PX", x"546865206ee28099657374206d656d6520746f6b656e206f6e20737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1753121015524.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEAD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEAD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

