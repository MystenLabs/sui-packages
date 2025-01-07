module 0xe3aa4bd6a3086b0398e1083909ef188c4ff34d7acb8a02839dc09323f881a638::hmy {
    struct HMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMY>(arg0, 6, b"HMY", b"HotMommy", b"Well, hello there, naughty boy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_aaac836477.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

