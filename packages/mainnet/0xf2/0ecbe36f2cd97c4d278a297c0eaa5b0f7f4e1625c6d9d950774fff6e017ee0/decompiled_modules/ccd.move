module 0xf20ecbe36f2cd97c4d278a297c0eaa5b0f7f4e1625c6d9d950774fff6e017ee0::ccd {
    struct CCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCD>(arg0, 6, b"CCD", b"CoreCard", b"CoreCard is a decentralized pass based on the Coresky ecosystem. On the Coresky platform, users can bind their CoreCard, and each week, the CoreCard will generate a certain number of tickets. These tickets can be used to participate in Coresky Launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732777232389.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

