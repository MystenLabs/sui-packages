module 0x12b48f1302ca05b3a664530a87f2b5fa1081545b9666467b3bd74380572f8441::mokhoavn {
    struct MOKHOAVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOKHOAVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOKHOAVN>(arg0, 9, b"MOKHOAVN", b"Mokhoa", b"Unlock code", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6da46fa5-0ff4-4fad-b881-8e065ee61a73.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOKHOAVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOKHOAVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

