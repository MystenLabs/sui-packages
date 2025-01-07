module 0xc04f0266e2fbd074de3d4c7e98472e6fc42397607a3c4f574c0ef61d4883c03f::fnky {
    struct FNKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNKY>(arg0, 9, b"FNKY", b"FUNKY", b"JUST MEME FOR US. LETS MAKE FUN FOR US", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe12dc67-e400-48f5-bb34-6523ae8a7d55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FNKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

