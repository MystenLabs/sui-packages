module 0x3ee6ddbeb83a6cb6c66b4bf3dbfd931b20c83a0cbd8b0a0d095dc38f41a9e84f::lori {
    struct LORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORI>(arg0, 6, b"LORI", b"lorikeet", b"The rainbow lorikeet is a species of parrot found in Australia. It is common along the eastern seaboard, from northern Queensland to South Australia. Its habitat is rainforest, coastal bush and woodland areas, now moved to sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Lorikeet_31ef3492f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LORI>>(v1);
    }

    // decompiled from Move bytecode v6
}

