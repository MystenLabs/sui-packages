module 0xd99a0e298c3ee1294c0905907282b6766fa886b125589abf5ce470a959b28d24::dragsu {
    struct DRAGSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAGSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAGSU>(arg0, 6, b"DRAGSU", b"Dragon Sui", b"Come for the memes, stay for to the moon, $DRAGSU The first AI token on the sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014505_42c08b3f53.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAGSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAGSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

