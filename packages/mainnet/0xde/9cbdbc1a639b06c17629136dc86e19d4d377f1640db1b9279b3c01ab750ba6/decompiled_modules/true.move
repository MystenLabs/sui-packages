module 0xde9cbdbc1a639b06c17629136dc86e19d4d377f1640db1b9279b3c01ab750ba6::true {
    struct TRUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUE>(arg0, 9, b"TRUE", b"Trump Elon", b"The first Trump x Elon coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc22cde3-5250-4614-a8e0-863ccda096f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

