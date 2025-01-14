module 0xb0d945a3be2b15c04a96c0409f316e747f430cbfea3cd0559ecf475c99717930::bbelleyeah {
    struct BBELLEYEAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBELLEYEAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBELLEYEAH>(arg0, 6, b"Bbelleyeah", b"Baby elleyeah", b"Can I get a...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736816881170.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBELLEYEAH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBELLEYEAH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

