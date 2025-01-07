module 0x140a2bc495ea4b1b2b87ca9d4542230501354c6e061623f7d5497768d36cf839::gau {
    struct GAU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAU>(arg0, 9, b"GAU", b"Raja sahu", b"Good token to launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7bea1518-babb-415a-b036-4d7b794c012c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAU>>(v1);
    }

    // decompiled from Move bytecode v6
}

