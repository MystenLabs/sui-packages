module 0x6a31ff414887b300d1d2fca2632543783c0054cf467b620cb537ef773b607ebc::bro {
    struct BRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRO>(arg0, 9, b"BRO", b"Hnt", b"It's just fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c21247e6-033d-4933-99c8-79bc84ed7cbe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

