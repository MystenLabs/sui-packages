module 0xa63d6828aed3773ab2a0fe287568dbc4c4eb72ded5ce877e2543aacb6762807d::bshark {
    struct BSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSHARK>(arg0, 6, b"BSHARK", b"BULL SHARK", b"Meme of Swift, strong, and determined BullSharks. This bull shark will lead the Sui blockchain ocean with strategy and precision. Be victorious and gain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734565505212.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSHARK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSHARK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

