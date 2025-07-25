module 0x9afb9a1c63a9bbaba650ef0a6b473b9874882cd63aab9570b99274e8f796f00::pawtato_titanium_splinter {
    struct PAWTATO_TITANIUM_SPLINTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_TITANIUM_SPLINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_TITANIUM_SPLINTER>(arg0, 9, b"TITAN_SPLINTER", b"Pawtato Titanium Splinter", b"Very rare fragment of a legendary alloy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/titanium-splinter.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_TITANIUM_SPLINTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_TITANIUM_SPLINTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun transfer_titanium_splinter(arg0: 0x2::coin::Coin<PAWTATO_TITANIUM_SPLINTER>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PAWTATO_TITANIUM_SPLINTER>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

