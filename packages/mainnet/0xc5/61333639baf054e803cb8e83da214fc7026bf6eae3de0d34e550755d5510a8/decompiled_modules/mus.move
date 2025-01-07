module 0xc561333639baf054e803cb8e83da214fc7026bf6eae3de0d34e550755d5510a8::mus {
    struct MUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUS>(arg0, 6, b"MUS", b"Mouse", b"Third generation of memes. First Dogs then cats now time for mouses", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/themouseonsui_a_rich_mouse_has_a_cheese_at_right_hand_and_a_big_d2152be5_59f2_4555_a95f_cf2044dde4c6_d125a6ebc2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

