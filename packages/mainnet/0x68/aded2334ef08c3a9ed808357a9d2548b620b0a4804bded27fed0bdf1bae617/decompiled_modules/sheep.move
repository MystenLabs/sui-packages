module 0x68aded2334ef08c3a9ed808357a9d2548b620b0a4804bded27fed0bdf1bae617::sheep {
    struct SHEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEEP>(arg0, 9, b"SHEEP", b" SHEEP", b"S H E E P", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60696cb0-2f9f-4306-92b5-6ad0e3e065b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

