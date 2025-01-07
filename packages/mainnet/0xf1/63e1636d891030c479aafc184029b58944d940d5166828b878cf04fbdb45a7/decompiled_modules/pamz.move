module 0xf163e1636d891030c479aafc184029b58944d940d5166828b878cf04fbdb45a7::pamz {
    struct PAMZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAMZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAMZ>(arg0, 9, b"PAMZ", b"Esther ", b"Morenikeji", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/169b83f1-779c-4c93-97b1-a8920c4ebc59.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAMZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAMZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

