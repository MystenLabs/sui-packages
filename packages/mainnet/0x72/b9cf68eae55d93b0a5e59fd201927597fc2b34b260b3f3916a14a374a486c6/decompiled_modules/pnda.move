module 0x72b9cf68eae55d93b0a5e59fd201927597fc2b34b260b3f3916a14a374a486c6::pnda {
    struct PNDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNDA>(arg0, 9, b"PNDA", b"Panda", b"Panda is new Meme token.Funny meme token , in SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/16bde374-de84-406c-8105-e1924d3dc1e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

