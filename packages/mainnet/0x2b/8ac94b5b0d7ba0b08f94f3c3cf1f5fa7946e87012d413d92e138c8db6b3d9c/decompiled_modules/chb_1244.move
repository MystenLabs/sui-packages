module 0x2b8ac94b5b0d7ba0b08f94f3c3cf1f5fa7946e87012d413d92e138c8db6b3d9c::chb_1244 {
    struct CHB_1244 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHB_1244, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHB_1244>(arg0, 9, b"CHB_1244", b"MOON", b"TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a4c7c8a0-6d7d-4934-b9f4-b8b6e645107f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHB_1244>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHB_1244>>(v1);
    }

    // decompiled from Move bytecode v6
}

