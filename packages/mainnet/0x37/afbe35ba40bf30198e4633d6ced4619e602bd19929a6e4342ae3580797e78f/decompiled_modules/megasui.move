module 0x37afbe35ba40bf30198e4633d6ced4619e602bd19929a6e4342ae3580797e78f::megasui {
    struct MEGASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGASUI>(arg0, 6, b"MEGASUI", b"First MegaSui", b"MEGASUI is for the rebels, the degens who don't fold.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/apple_touch_icon_da18a2f582.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEGASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

