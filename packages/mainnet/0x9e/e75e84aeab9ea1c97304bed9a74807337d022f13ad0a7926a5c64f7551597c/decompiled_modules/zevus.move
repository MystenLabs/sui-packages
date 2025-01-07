module 0x9ee75e84aeab9ea1c97304bed9a74807337d022f13ad0a7926a5c64f7551597c::zevus {
    struct ZEVUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEVUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEVUS>(arg0, 9, b"ZEVUS", b"Zevs", b"Zevs cats ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/76c051db-5b2d-4414-9405-cbe0f44b38ba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEVUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEVUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

