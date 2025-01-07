module 0xd1432fc8f995750fe882404084ba53e77854fadeab137501e8c441d5149c7a66::ttm {
    struct TTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTM>(arg0, 9, b"TTM", b"The time ", b"The time a meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5ab84cdd-3330-4c3a-9b26-40916366ebf0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTM>>(v1);
    }

    // decompiled from Move bytecode v6
}

