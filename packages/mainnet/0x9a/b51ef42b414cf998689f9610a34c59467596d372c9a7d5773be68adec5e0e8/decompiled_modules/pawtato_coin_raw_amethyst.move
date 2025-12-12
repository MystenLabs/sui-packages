module 0x9ab51ef42b414cf998689f9610a34c59467596d372c9a7d5773be68adec5e0e8::pawtato_coin_raw_amethyst {
    struct PAWTATO_COIN_RAW_AMETHYST has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_RAW_AMETHYST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_RAW_AMETHYST>(arg0, 9, b"RAW_AMETHYST", b"Pawtato Raw Amethyst", b"An uncut and unpolished Amethyst, showing its natural shape and rough surface.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/amethyst-raw.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_RAW_AMETHYST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_RAW_AMETHYST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_raw_amethyst(arg0: 0x2::coin::Coin<PAWTATO_COIN_RAW_AMETHYST>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_RAW_AMETHYST>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

