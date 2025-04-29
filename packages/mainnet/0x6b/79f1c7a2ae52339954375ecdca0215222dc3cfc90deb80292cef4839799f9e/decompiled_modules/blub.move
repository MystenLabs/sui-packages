module 0x6b79f1c7a2ae52339954375ecdca0215222dc3cfc90deb80292cef4839799f9e::blub {
    struct BLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUB>(arg0, 6, b"BLUB", b"BLUB SUI", b"A Degen Fish in the Waters of the Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BLUBB_02f6703a7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

