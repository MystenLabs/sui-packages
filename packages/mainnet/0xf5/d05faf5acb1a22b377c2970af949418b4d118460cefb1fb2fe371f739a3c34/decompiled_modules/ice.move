module 0xf5d05faf5acb1a22b377c2970af949418b4d118460cefb1fb2fe371f739a3c34::ice {
    struct ICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICE>(arg0, 6, b"ICE", b"liptonIce", b"Sip into the cool, refreshing world of Lipton Ice Tea  where every token drop is a burst of sunshine! Whether you're chilling under the summer sun or just vibing, Lipton's zesty blend of tea and citrus will lift your spirits. Who needs a reason to smile when you've got Lipton in hand? Dive in, sip happy, and keep the good vibes tokens flowing! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lipton_Ice_c4444f7c0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

