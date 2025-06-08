module 0x55ab6424780e0ec76000f316cc4247be8889f3d714d6424d34a12acec38719c8::arnold {
    struct ARNOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARNOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARNOLD>(arg0, 6, b"ARNOLD", b"Arnold", b"Own the legacy, Shape the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749294808050.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARNOLD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARNOLD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

