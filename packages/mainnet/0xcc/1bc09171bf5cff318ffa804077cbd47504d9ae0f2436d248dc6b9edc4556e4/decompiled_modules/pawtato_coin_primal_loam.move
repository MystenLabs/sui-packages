module 0xcc1bc09171bf5cff318ffa804077cbd47504d9ae0f2436d248dc6b9edc4556e4::pawtato_coin_primal_loam {
    struct PAWTATO_COIN_PRIMAL_LOAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_PRIMAL_LOAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_PRIMAL_LOAM>(arg0, 9, b"PRIMAL_LOAM", b"Pawtato Primal Loam", b"A rare patch of highly fertile soil rich in nutrients.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/primal-loam.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_PRIMAL_LOAM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_PRIMAL_LOAM>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_primal_loam(arg0: 0x2::coin::Coin<PAWTATO_COIN_PRIMAL_LOAM>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_PRIMAL_LOAM>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

