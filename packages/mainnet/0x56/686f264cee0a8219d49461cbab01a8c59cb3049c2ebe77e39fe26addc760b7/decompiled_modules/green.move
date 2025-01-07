module 0x56686f264cee0a8219d49461cbab01a8c59cb3049c2ebe77e39fe26addc760b7::green {
    struct GREEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREEN>(arg0, 9, b"GREEN", b"Greeny", b"First ever green meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ab6e7af9-7177-4214-8bc1-c88b65b7831e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

