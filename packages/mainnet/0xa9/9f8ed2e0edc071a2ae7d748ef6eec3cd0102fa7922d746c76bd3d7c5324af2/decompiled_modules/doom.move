module 0xa99f8ed2e0edc071a2ae7d748ef6eec3cd0102fa7922d746c76bd3d7c5324af2::doom {
    struct DOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOM>(arg0, 9, b"DOOM", b"DOOM GUY", b"IDDQD included ;)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4d6d9a75-b47b-44f7-b60e-be9724bb92b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

