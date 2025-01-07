module 0x2c8861cb910a683d906ede8c138ef12a1c4ddfebf62a056c6ebba04f18c58cd7::pumppp {
    struct PUMPPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPPP>(arg0, 9, b"PUMPPP", b"Wewepump", b"Pummp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bfec705c-7671-4174-ae60-331ebf07853f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUMPPP>>(v1);
    }

    // decompiled from Move bytecode v6
}

