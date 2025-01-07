module 0xae7b37ff3919c449f9b688fdd2b94ce56ca7e63decfd861d2dc89b6176ed8fa0::rt {
    struct RT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RT>(arg0, 9, b"RT", b"Rty", b"Tyffhhjj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7ee6cc1b-8058-4f39-9439-7304582a2185.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RT>>(v1);
    }

    // decompiled from Move bytecode v6
}

