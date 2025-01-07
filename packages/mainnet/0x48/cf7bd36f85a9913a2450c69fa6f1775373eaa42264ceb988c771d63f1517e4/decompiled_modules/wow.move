module 0x48cf7bd36f85a9913a2450c69fa6f1775373eaa42264ceb988c771d63f1517e4::wow {
    struct WOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOW>(arg0, 9, b"WOW", b"Hawow", b"PumpWow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec7e65a0-79ce-4b55-9c22-f0bf694ba613.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

