module 0xa123c8edc83f0cdff590dc2cadbbed8d61d5e9bcb0d614cee63766b399391ad0::fart {
    struct FART has drop {
        dummy_field: bool,
    }

    fun init(arg0: FART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FART>(arg0, 6, b"FART", b"FART DUST", b"When you sit on $TOILET you naturally $FART", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1743444716828.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FART>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FART>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

