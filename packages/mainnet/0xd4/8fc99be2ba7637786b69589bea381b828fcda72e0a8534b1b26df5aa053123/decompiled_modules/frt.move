module 0xd48fc99be2ba7637786b69589bea381b828fcda72e0a8534b1b26df5aa053123::frt {
    struct FRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRT>(arg0, 9, b"FRT", b"Frog", b"Just a frog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15e90c01-2cfa-4527-9ae2-bb114c2ffdd9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

