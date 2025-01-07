module 0x5b1b698477ffb7eee2052007f06ce8877eea53c30c95e0ae5936e927607b62e8::yuguda {
    struct YUGUDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUGUDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUGUDA>(arg0, 9, b"YUGUDA", b"Yugu", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/eb00d9b1-b7a0-4c52-be5d-9db6478ac560.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUGUDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUGUDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

