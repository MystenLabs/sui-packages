module 0x1cbe0bb89cb5a231efc0688daf7c5c9bfa0d1c11306be604dc512ab9ace36d10::pawtato_coin_gravel {
    struct PAWTATO_COIN_GRAVEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_GRAVEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_GRAVEL>(arg0, 9, b"GRAVEL", b"Pawtato Gravel", b"Versatile material used to construct building foundations or for decorative purposes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/gravel.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_GRAVEL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_GRAVEL>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_gravel(arg0: 0x2::coin::Coin<PAWTATO_COIN_GRAVEL>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_COIN_GRAVEL>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

