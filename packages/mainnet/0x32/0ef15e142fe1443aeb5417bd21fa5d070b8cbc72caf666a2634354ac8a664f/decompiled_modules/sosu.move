module 0x320ef15e142fe1443aeb5417bd21fa5d070b8cbc72caf666a2634354ac8a664f::sosu {
    struct SOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOSU>(arg0, 6, b"SOSU", b"Spell of Sui", b"Unlock your potential with the Spell of SUI. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sosub_5f9ab40fb0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

