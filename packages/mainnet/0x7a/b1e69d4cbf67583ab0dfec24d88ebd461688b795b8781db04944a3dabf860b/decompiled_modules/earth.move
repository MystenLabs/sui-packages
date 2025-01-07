module 0x7ab1e69d4cbf67583ab0dfec24d88ebd461688b795b8781db04944a3dabf860b::earth {
    struct EARTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: EARTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EARTH>(arg0, 9, b"EARTH", b"Earth", b"It is the third planet of the solar system, which is located at a distance of 149,600,000 kilometers from the sun. This planet is the densest (due to having large sources of iron and other metals) ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc4cfc71-3b2b-4c58-84e1-be010c54124b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EARTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EARTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

