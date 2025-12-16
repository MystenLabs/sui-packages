module 0x64c81fda079883e04016c740fa6cad992eadb92ecd1821fc5587f9619c49193e::pawtato_coin_chipped_emerald {
    struct PAWTATO_COIN_CHIPPED_EMERALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_CHIPPED_EMERALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_CHIPPED_EMERALD>(arg0, 9, b"CHIPPED_EMERALD", b"Pawtato Chipped Emerald", b"A small and slightly damaged Emerald with visible imperfections that reduce brilliance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/emerald-chipped.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_CHIPPED_EMERALD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_CHIPPED_EMERALD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_chipped_emerald(arg0: 0x2::coin::Coin<PAWTATO_COIN_CHIPPED_EMERALD>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_CHIPPED_EMERALD>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

