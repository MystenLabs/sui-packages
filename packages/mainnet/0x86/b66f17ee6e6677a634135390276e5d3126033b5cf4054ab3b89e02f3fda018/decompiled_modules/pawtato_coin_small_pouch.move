module 0x86b66f17ee6e6677a634135390276e5d3126033b5cf4054ab3b89e02f3fda018::pawtato_coin_small_pouch {
    struct PAWTATO_COIN_SMALL_POUCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_SMALL_POUCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_SMALL_POUCH>(arg0, 9, b"SMALL_POUCH", b"Pawtato Small Pouch", b"A small container which can be opened to reveal its contents", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/pouch-small.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_SMALL_POUCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_SMALL_POUCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_small_pouch(arg0: 0x2::coin::Coin<PAWTATO_COIN_SMALL_POUCH>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_SMALL_POUCH>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

