module 0xbe8f9a18e844fe3979593fac1e4c588410e2f05ae4ac14cfdb3d3e3f61175582::bhaha {
    struct BHAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHAHA>(arg0, 9, b"BHAHA", b"BAHAHA", b"HAHA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6be1b448-d1ac-436f-8c7a-3ab93f571129.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHAHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BHAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

