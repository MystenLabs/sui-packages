module 0x63ec8892f518e37e0f9e4851827a0632f399046dc164e299caa09b3bd8874c8c::baozou {
    struct BAOZOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAOZOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAOZOU>(arg0, 6, b"BAOZOU", b"BaoZou On Sui", b"$BAOZOU - China's biggest meme series about funny daily frustrations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_eb1545a1fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAOZOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAOZOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

