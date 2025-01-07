module 0x9e2e06afb4bcf5f2d93fc2870696dab2a2b8ed0a9d14988622c8d9f8c9db3ff::snd {
    struct SND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SND>(arg0, 9, b"SND", b"Snopdy", b"Token for community ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/38d086b5-4c45-4348-baa8-6f0aa39f00e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SND>>(v1);
    }

    // decompiled from Move bytecode v6
}

