module 0x86cc9bae2149e675fb9e344be5ac9f015c71a4138e3e6338fea038982365e86d::impeach {
    struct IMPEACH has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMPEACH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMPEACH>(arg0, 6, b"IMPEACH", b"Impeach Trump", b"$IMPEACH is a revolutionary memecoin created as a form of protest and satire against the excessive political hype in the crypto world, particularly fueled by coins with no real fundamentals. Inspired by the concept of \"impeachment,\" this coin aims to \"put on trial\" speculative games and provide a platform for the community to voice their opinions in a creative and ironic way.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000046093_e9ef8434bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMPEACH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IMPEACH>>(v1);
    }

    // decompiled from Move bytecode v6
}

