module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_iron {
    struct PAWTATO_IRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_IRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_IRON>(arg0, 9, b"IRON", b"Pawtato Iron", b"Strong iron mined from Pawtato Lands.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/iron.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_IRON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_IRON>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_iron(arg0: 0x2::coin::Coin<PAWTATO_IRON>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_IRON>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

