module 0x1e64d354dbbb61a3a94da33b8b25712f43f45aa5919ec959f7d38a1bfe9c8e7c::tommui {
    struct TOMMUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMMUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMMUI>(arg0, 9, b"TOMMUI", b"Tom", b"Memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a7e3f1b8-bf28-43b9-9356-d685a7a6ed28.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMMUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOMMUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

