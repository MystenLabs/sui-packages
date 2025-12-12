module 0x65e2ece04bc35d4f2452fe8fa7b6f55ed6e4fe4c42a9e7f81c492cae62a78d38::pawtato_coin_raw_emerald {
    struct PAWTATO_COIN_RAW_EMERALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_RAW_EMERALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_RAW_EMERALD>(arg0, 9, b"RAW_EMERALD", b"Pawtato Raw Emerald", b"An uncut and unpolished Emerald, showing its natural shape and rough surface.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/emerald-raw.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_RAW_EMERALD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_RAW_EMERALD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_raw_emerald(arg0: 0x2::coin::Coin<PAWTATO_COIN_RAW_EMERALD>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_RAW_EMERALD>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

