module 0x928f1d85bfd9320c4b71285ea109d9c834840328ffe5196aa1291db3086d4c12::kangaroo {
    struct KANGAROO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KANGAROO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KANGAROO>(arg0, 6, b"KANGAROO", b"Kung Fu Kangaroo", b"Like Kung Fu Kangaroos journey of perseverance and growth, $KFK aims to make a positive global impact by helping children thrive, one step at a time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yy9k_XE_9_J_400x400_0f22dfab90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KANGAROO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KANGAROO>>(v1);
    }

    // decompiled from Move bytecode v6
}

