module 0x5b5d7fc9ee82f4e8c6a868d4fbf220809eec7c2f8386835300b4afccf225a15c::suiboss {
    struct SUIBOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOSS>(arg0, 9, b"SUIBOSS", b"Sui Boss", b"The king and father of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/133d5fd1-9106-4419-805e-2b1e21ace052.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBOSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

