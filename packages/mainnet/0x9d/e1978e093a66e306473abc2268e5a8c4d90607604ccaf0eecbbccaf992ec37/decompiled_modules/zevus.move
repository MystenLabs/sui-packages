module 0x9de1978e093a66e306473abc2268e5a8c4d90607604ccaf0eecbbccaf992ec37::zevus {
    struct ZEVUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEVUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEVUS>(arg0, 9, b"ZEVUS", b"Zevs", b"Zevs cats ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc3643ac-d317-4e81-bbbf-f0ccd0f7e958.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEVUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEVUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

