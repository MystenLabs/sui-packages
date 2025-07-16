module 0x30021448e6d54825ced6d2b73f3b763a0da8a28c1c42fd6f0b864323ac60ab45::pawtato_coin_titanium_splinter {
    struct PAWTATO_COIN_TITANIUM_SPLINTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_TITANIUM_SPLINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_TITANIUM_SPLINTER>(arg0, 9, b"TITANIUM_SPLINTER", b"Pawtato Titanium Splinter", b"Ultra-rare metal fragments with extraordinary strength and durability.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/titanium-splinter.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_TITANIUM_SPLINTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_TITANIUM_SPLINTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_titanium_splinter(arg0: 0x2::coin::Coin<PAWTATO_COIN_TITANIUM_SPLINTER>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_TITANIUM_SPLINTER>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

