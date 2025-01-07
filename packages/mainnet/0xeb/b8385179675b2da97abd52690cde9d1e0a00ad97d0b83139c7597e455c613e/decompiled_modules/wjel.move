module 0xebb8385179675b2da97abd52690cde9d1e0a00ad97d0b83139c7597e455c613e::wjel {
    struct WJEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WJEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WJEL>(arg0, 6, b"WJEL", b"WOBBLY JELLY", b"Wiggling its way through the meme space, Wobbly Jelly is smooth, sweet, and sticky with gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_034320559_d3608cc2c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WJEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WJEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

