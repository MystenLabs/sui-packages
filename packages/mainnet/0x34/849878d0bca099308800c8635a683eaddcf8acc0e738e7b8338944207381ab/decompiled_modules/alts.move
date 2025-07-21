module 0x34849878d0bca099308800c8635a683eaddcf8acc0e738e7b8338944207381ab::alts {
    struct ALTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALTS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ALTS>(arg0, 6, b"ALTS", b"altseason", b"@suilaunchcoin $ALTS + altseason  coin https://t.co/dyOhY6tMo3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/alts-xj5z1b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALTS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALTS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

