module 0x165d36b18304ab45d366d6d59b71a35dbbd69cca378a031eea4beb83e15b9df9::elonmust {
    struct ELONMUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONMUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONMUST>(arg0, 9, b"ELONMUST", b"X", b"Buy Premium Now ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54bfc88a-7c05-4a80-a5b1-ccc8cbc93356.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONMUST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONMUST>>(v1);
    }

    // decompiled from Move bytecode v6
}

