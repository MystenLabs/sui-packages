module 0xe775cf159eeec285f7ec1278317f27bfb8a6a45f5c79bff12f86e314cbb2ef4b::vlad {
    struct VLAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: VLAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VLAD>(arg0, 9, b"VLAD", b"VLADIMIR", b"Sarcasm refers to the use of words that mean the opposite of what you really want to say", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JXgK7s9.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VLAD>(&mut v2, 120000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VLAD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VLAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

