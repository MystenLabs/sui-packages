module 0xaf5981f9bee15d210e25f2933671ed587a810ed8cb8819d05fa967f2d4913ff::pawtato_coin_dawnstone {
    struct PAWTATO_COIN_DAWNSTONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_DAWNSTONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_DAWNSTONE>(arg0, 9, b"DAWNSTONE", b"Pawtato Dawnstone", b"A rare gem emitting a dim light resembling the morning sun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/dawnstone.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_DAWNSTONE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_DAWNSTONE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_dawnstone(arg0: 0x2::coin::Coin<PAWTATO_COIN_DAWNSTONE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_DAWNSTONE>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

