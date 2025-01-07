module 0x26c85738ac648396b46e490d440a9f35182722b544b52f1a7155344e36261cb8::dmoon {
    struct DMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMOON>(arg0, 9, b"DMOON", b"DOGMOON", b"DOGMOON LIVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76d0d340-0bbc-4a13-aec9-27f19b8826dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

