module 0x568b74e8577dfc29d111ee7ecd1d59b5ac63a38b4eee158f5ca37ba4a199cda4::panic {
    struct PANIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANIC>(arg0, 6, b"PANIC", b"PANIC PEPE", b"NO BS! JUST PURE MEME! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735406635659.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PANIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

