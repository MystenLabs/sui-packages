module 0xe1b0d1a2c2eebaf6dd20a1fd88c4f89fdb3d34774722d30f672b074cffee8182::pawtato_coin_iron_bar {
    struct PAWTATO_COIN_IRON_BAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_IRON_BAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_IRON_BAR>(arg0, 9, b"IRON_BAR", b"Pawtato Iron Bar", b"Processed iron bars refined from raw iron ore.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/iron-bar.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_IRON_BAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_IRON_BAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_iron_bar(arg0: 0x2::coin::Coin<PAWTATO_COIN_IRON_BAR>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_IRON_BAR>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

