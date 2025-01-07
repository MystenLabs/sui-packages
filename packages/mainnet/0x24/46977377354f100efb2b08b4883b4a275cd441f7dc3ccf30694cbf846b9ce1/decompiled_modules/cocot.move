module 0x2446977377354f100efb2b08b4883b4a275cd441f7dc3ccf30694cbf846b9ce1::cocot {
    struct COCOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCOT>(arg0, 6, b"COCOT", b"COCO T", b"I pity the fool who doesnt love chocolate!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/negao_52d58ecb44.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

