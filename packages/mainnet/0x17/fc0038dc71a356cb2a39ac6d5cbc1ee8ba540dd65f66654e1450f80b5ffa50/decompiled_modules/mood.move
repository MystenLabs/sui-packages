module 0x17fc0038dc71a356cb2a39ac6d5cbc1ee8ba540dd65f66654e1450f80b5ffa50::mood {
    struct MOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOD>(arg0, 6, b"Mood", b"Baby Moo Deng SUI", b"This is Moo Deng Baby on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Moo_deng_b8511cfaa2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

