module 0x8a5bec2b65ac6bcf80b41c4723290cf6c092528e1c95ee2c9a407b118f9963b1::flip {
    struct FLIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLIP>(arg0, 6, b"FLIP", b"SUI FLIP", b"SUI FLIP TO THE MOON BUY AND HODL", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/problembo_result_20241006152801_0_d4e210a15c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

