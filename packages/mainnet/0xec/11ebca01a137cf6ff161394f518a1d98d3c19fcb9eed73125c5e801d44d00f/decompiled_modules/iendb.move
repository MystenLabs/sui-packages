module 0xec11ebca01a137cf6ff161394f518a1d98d3c19fcb9eed73125c5e801d44d00f::iendb {
    struct IENDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: IENDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IENDB>(arg0, 9, b"IENDB", b"nznz", b"jdn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f82a5906-1c60-4379-ad7a-fba2015fc870.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IENDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IENDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

