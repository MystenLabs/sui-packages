module 0x2a03c5f7c5b2a2b0befba1b07a7f6e0463adee19d9e86142648c7891c7b56367::shoto {
    struct SHOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SHOTO>(arg0, 6, b"SHOTO", b"ShotoTheGambler", b"@suilaunchcoin $SHOTO + ShotoTheGambler https://t.co/xcR2RD7Y4c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GwHmoRZWsAAK5VY.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHOTO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOTO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

