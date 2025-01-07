module 0xd895909b850047c7a77368fbb3a1b4cd52c0cd4711898e82184af89b2bc6fe53::charmvn {
    struct CHARMVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARMVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARMVN>(arg0, 9, b"CHARMVN", b"CHARM", b"Charm pet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbe343d2-9916-437e-bc52-859336199bc9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARMVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHARMVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

