module 0x9526f348d99d4484b2c8cdafb58e31da20baa78a98294363563716e45b943421::fgc {
    struct FGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FGC>(arg0, 9, b"FGC", b"Kingsley", b"FGC is a good token to buy and hold for good return. Its a community driving Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15119ba4-fefc-4a00-8227-607624ebb29a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

