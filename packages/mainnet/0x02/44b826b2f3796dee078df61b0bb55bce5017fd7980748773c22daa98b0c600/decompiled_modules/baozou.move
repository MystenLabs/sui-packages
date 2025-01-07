module 0x244b826b2f3796dee078df61b0bb55bce5017fd7980748773c22daa98b0c600::baozou {
    struct BAOZOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAOZOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAOZOU>(arg0, 6, b"BAOZOU", b"BaoZou ManHua", b"$BAOZOU - China's biggest meme series about funny daily frustrations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_fc7935a750.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAOZOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAOZOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

