module 0xecdf9417652b60b9abf09d8d6278242d7d0799375ed55e301c32d101517c250::dnky {
    struct DNKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNKY>(arg0, 9, b"DNKY", b"DONKEY ", b"First Donkey Meme Coin Created By Wave Wallet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/608cdc43-07a9-48cd-a5c4-89cefefe85ea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

