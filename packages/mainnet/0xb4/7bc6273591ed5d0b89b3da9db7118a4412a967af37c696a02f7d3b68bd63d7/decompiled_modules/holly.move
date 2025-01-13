module 0xb47bc6273591ed5d0b89b3da9db7118a4412a967af37c696a02f7d3b68bd63d7::holly {
    struct HOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLLY>(arg0, 6, b"HOLLY", b"Holly Cat", b"The shining Holly Cat on SUI !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_28_1_a89182650f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

