module 0xa17db15fbfc509673076411f18fc3d33f7f60e629fb3c262ddf24e1b2f52d03a::pawtato_coin_paper {
    struct PAWTATO_COIN_PAPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_PAPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_PAPER>(arg0, 9, b"PAPER", b"Pawtato Paper", b"Commonly used to write or draw on, but can also function as wrapping material.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/paper.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_PAPER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_PAPER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_paper(arg0: 0x2::coin::Coin<PAWTATO_COIN_PAPER>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_PAPER>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

