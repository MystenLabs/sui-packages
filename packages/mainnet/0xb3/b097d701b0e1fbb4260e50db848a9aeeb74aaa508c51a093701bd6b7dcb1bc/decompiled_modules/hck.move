module 0xb3b097d701b0e1fbb4260e50db848a9aeeb74aaa508c51a093701bd6b7dcb1bc::hck {
    struct HCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HCK>(arg0, 6, b"HCK", b"What the Heck!", b"The best thing to say when stuff happens and you still don't want to offend anyone!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732232186171.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

