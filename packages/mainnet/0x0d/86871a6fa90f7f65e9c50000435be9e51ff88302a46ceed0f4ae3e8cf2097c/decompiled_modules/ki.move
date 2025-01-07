module 0xd86871a6fa90f7f65e9c50000435be9e51ff88302a46ceed0f4ae3e8cf2097c::ki {
    struct KI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KI>(arg0, 9, b"KI", b"jsjdn", b"jdndn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f8b11ec6-e07d-41c5-ba06-cce99935e494.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KI>>(v1);
    }

    // decompiled from Move bytecode v6
}

