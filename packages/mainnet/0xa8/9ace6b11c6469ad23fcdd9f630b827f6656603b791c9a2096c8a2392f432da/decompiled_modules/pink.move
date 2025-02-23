module 0xa89ace6b11c6469ad23fcdd9f630b827f6656603b791c9a2096c8a2392f432da::pink {
    struct PINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINK>(arg0, 6, b"Pink", b"PinkBunny On Sui", x"506c656173652072656164206361726566756c6c7920616e6420666f6c6c6f77207468652067726f75702072756c657320746f20656e737572652061206865616c74687920616e6420667269656e646c7920656e7669726f6e6d656e7420666f722065766572796f6e652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_29_14_37_32_ecee2526d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

