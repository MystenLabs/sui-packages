module 0xf0ddd53cbc87724c2ba77b0031df5aed69c2c6058c4c0940f6f9cd5a72a93ea::trm {
    struct TRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRM>(arg0, 9, b"TRM", b"terminator", b"The Real Terminator! Better Than Arnold!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f9b6512c-d540-4586-afd6-74064070545f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

