module 0x5f81efb6caebef0fc96c1461ccd5920e022bae2aa4f197ee930bbbb4833c31c9::elsa {
    struct ELSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELSA>(arg0, 9, b"ELSA", b"Elsa", b"Nfa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/290bc9d3-5638-4986-a39d-59b71218159a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

