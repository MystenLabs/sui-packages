module 0x8574383098c964bf0b95b16f3f4f6d7e94d35680264fb5210d4977a97b85aca7::pawtato_coin_crystal {
    struct PAWTATO_COIN_CRYSTAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_CRYSTAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_CRYSTAL>(arg0, 9, b"CRYSTAL", b"Pawtato Crystal", b"Rare magical crystals found in the deepest parts of Pawtato Lands.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/crystal.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_CRYSTAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_CRYSTAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_crystal(arg0: 0x2::coin::Coin<PAWTATO_COIN_CRYSTAL>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_CRYSTAL>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

