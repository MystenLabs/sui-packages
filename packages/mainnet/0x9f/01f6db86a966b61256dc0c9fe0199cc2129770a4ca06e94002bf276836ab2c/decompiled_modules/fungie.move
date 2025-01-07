module 0x9f01f6db86a966b61256dc0c9fe0199cc2129770a4ca06e94002bf276836ab2c::fungie {
    struct FUNGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNGIE>(arg0, 6, b"FUNGIE", b"Guinness Dolphin $FUNGIE", b"THE DOLPHIN WITH GUINESS BOOK OF WORLD RECORD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/fungie_0220c0d7e9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUNGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

