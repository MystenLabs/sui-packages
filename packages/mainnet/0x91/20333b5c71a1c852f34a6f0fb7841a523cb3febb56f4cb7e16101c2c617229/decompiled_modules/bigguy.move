module 0x9120333b5c71a1c852f34a6f0fb7841a523cb3febb56f4cb7e16101c2c617229::bigguy {
    struct BIGGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGGUY>(arg0, 6, b"BIGGUY", b"BigGuy", b"Just a big dude", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736526848394.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIGGUY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGGUY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

