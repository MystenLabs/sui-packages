module 0xb76607645f361840bb47e05d53254d69e5e685b061447e065ff144a52b39ef27::burak {
    struct BURAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURAK>(arg0, 9, b"BURAK", b"Horse", b"meme horse ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/04b0f812-2a56-4f70-96bf-22259fea9864.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BURAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

