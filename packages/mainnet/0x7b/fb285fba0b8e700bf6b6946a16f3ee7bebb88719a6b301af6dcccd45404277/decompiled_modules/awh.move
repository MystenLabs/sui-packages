module 0x7bfb285fba0b8e700bf6b6946a16f3ee7bebb88719a6b301af6dcccd45404277::awh {
    struct AWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWH>(arg0, 6, b"AWH", b"AKITA WIF HAT SUI", b" Welcome to the Akitawifhat community, where holding onto your tokens is like tending to a beautiful garden!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_01_35_10_5eecabad4a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

