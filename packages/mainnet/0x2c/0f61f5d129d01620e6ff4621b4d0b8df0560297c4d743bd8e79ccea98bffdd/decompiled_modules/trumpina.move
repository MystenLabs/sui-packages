module 0x2c0f61f5d129d01620e6ff4621b4d0b8df0560297c4d743bd8e79ccea98bffdd::trumpina {
    struct TRUMPINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPINA>(arg0, 6, b"TRUMPINA", b"The Trumpina Tor", b"The Trumpina Tor - Came with me if you want to moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960475570.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPINA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPINA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

