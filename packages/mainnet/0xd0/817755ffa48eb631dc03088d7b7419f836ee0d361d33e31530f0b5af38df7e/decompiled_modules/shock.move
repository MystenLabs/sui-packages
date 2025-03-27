module 0xd0817755ffa48eb631dc03088d7b7419f836ee0d361d33e31530f0b5af38df7e::shock {
    struct SHOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOCK>(arg0, 6, b"SHOCK", b"Aqua Shock", b"The waters are rising. We are watching, always. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4577_708927bac0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

