module 0xb408c4667b47656ee19dc5db456d2b65da40479970dfa029ca853a2e5ab65139::buu {
    struct BUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUU>(arg0, 6, b"BUU", b"Buu", b"In the shadows, a community arose, a new vibe, a mischievous vibe. Its all about the community and art. Together, were building a playful realm where creativity and fun collide.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000114679_c70f80c881.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

