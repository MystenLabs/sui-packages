module 0x7416ceef1d801941a6627a3917b02cccd7cd0e61e291c8393bdd167a3bec52c2::lazy {
    struct LAZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAZY>(arg0, 9, b"LAZY", b"LAZY COIN", b"LAZY COIN is the best current crypto assets", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0871a662-9da8-4c19-b1e6-d58e95586402.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

