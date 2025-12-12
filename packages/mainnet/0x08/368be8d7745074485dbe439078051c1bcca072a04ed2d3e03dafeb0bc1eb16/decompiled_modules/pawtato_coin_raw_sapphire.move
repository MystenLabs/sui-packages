module 0x8368be8d7745074485dbe439078051c1bcca072a04ed2d3e03dafeb0bc1eb16::pawtato_coin_raw_sapphire {
    struct PAWTATO_COIN_RAW_SAPPHIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_RAW_SAPPHIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_RAW_SAPPHIRE>(arg0, 9, b"RAW_SAPPHIRE", b"Pawtato Raw Sapphire", b"An uncut and unpolished Sapphire, showing its natural shape and rough surface.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/sapphire-raw.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_RAW_SAPPHIRE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_RAW_SAPPHIRE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_raw_sapphire(arg0: 0x2::coin::Coin<PAWTATO_COIN_RAW_SAPPHIRE>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_RAW_SAPPHIRE>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

