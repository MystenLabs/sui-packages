module 0x740fb1a0e5c6fb87275cab7d2badb739437492e0991f80dc363e3ba70836bea6::tyl {
    struct TYL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYL>(arg0, 9, b"TYL", b"Tuyul", b"a ghost who likes to take other people's money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/da94ebb2-32c4-4c5f-a6dc-9fd6f44e7979.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TYL>>(v1);
    }

    // decompiled from Move bytecode v6
}

