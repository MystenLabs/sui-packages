module 0x9be8c2bd4bcba3ed6b57d46874a276dbdf75b5cc2d7ca369440c94eab319ee5b::airdrip {
    struct AIRDRIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIRDRIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIRDRIP>(arg0, 9, b"AIRDRIP", b"Drwizzy", b"Memcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c01c0cb2-be94-4ef5-a4f8-b5b322ec50c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIRDRIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIRDRIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

