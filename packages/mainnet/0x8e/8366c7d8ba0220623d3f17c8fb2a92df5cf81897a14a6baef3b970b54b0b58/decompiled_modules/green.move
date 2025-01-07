module 0x8e8366c7d8ba0220623d3f17c8fb2a92df5cf81897a14a6baef3b970b54b0b58::green {
    struct GREEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREEN>(arg0, 9, b"GREEN", b"Green coin", b"GreenCoin is a utility token designed to promote sustainable living and support environmental initiatives. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3394cb92-1b6b-42e0-bb37-d182ce6b5e48.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

