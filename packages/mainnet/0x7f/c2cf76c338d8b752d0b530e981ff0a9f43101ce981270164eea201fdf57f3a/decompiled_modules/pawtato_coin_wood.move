module 0x7fc2cf76c338d8b752d0b530e981ff0a9f43101ce981270164eea201fdf57f3a::pawtato_coin_wood {
    struct PAWTATO_COIN_WOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_WOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_WOOD>(arg0, 9, b"WOOD", b"Pawtato Wood", b"Basic building material harvested from Pawtato Lands.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/wood.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_WOOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_WOOD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_wood(arg0: 0x2::coin::Coin<PAWTATO_COIN_WOOD>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_WOOD>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

