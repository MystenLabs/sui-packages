module 0xcc52234843ca8834945529c73d763a91e21cb28424e56ce40c6217005077da04::glump {
    struct GLUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLUMP>(arg0, 6, b"GLUMP", b"Glump", b"A little weird and sometimes silly, glump is something special, nobody really knows what he is. CTO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fighting_32_975f363710_d072b1094e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

