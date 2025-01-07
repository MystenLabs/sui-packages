module 0x7c1e0ca284aecc4f36735f43ce4c77d6b4eafc10230b51f4776db60982d721cd::nutz {
    struct NUTZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUTZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUTZ>(arg0, 6, b"NUTZ", b"Nutz", b"https://skynet.certik.com/projects/nutz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1722437477953_0e4e1fc505163f3656b711bc8b3bf45f_967418ba9c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUTZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUTZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

