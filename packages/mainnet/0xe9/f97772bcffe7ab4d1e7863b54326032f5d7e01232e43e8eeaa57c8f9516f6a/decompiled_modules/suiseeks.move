module 0xe9f97772bcffe7ab4d1e7863b54326032f5d7e01232e43e8eeaa57c8f9516f6a::suiseeks {
    struct SUISEEKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISEEKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISEEKS>(arg0, 6, b"SUISEEKS", b"MR.SUISEEKS", b"Look at me!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_94_28cef5423c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISEEKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISEEKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

