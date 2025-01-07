module 0x6dec9d1db937b0edd86aedbc2f02ab87d7c35c212a93993222231b34b6408732::acash {
    struct ACASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACASH>(arg0, 9, b"ACASH", b"Angry Cash", b"Angry is on web3?? WHAT IS GOING ON?!?!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd194069-2708-47e7-b9d3-bd8c319e8afa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ACASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

