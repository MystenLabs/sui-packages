module 0x21b6e628f706b363dd06d3083b6b5bf888579f133e974b7a66c9f959dbd5b8f9::nems {
    struct NEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMS>(arg0, 9, b"NEMS", b"Games", b"Games token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cb8aa151-29d5-4c02-9484-467fd6ee77d1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

