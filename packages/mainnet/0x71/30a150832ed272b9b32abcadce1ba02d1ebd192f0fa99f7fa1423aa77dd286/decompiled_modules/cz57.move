module 0x7130a150832ed272b9b32abcadce1ba02d1ebd192f0fa99f7fa1423aa77dd286::cz57 {
    struct CZ57 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZ57, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZ57>(arg0, 9, b"CZ57", b"Cz", b"C", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5c670685-b754-4438-b176-1880cac59978.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZ57>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CZ57>>(v1);
    }

    // decompiled from Move bytecode v6
}

