module 0xc5c7416e7ae5c520527d9daca16136b198980b2b029f5e10fe5c27490a8754be::pawtato_coin_fairy_dust {
    struct PAWTATO_COIN_FAIRY_DUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_FAIRY_DUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_FAIRY_DUST>(arg0, 9, b"FAIRY_DUST", b"Pawtato Fairy Dust", b"Powder with magical capabilities, which some say originates from mythical fairies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/fairy-dust.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_FAIRY_DUST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_FAIRY_DUST>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_fairy_dust(arg0: 0x2::coin::Coin<PAWTATO_COIN_FAIRY_DUST>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_FAIRY_DUST>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

