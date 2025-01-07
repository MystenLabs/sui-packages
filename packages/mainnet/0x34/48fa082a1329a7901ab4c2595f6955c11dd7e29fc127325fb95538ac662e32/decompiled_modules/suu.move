module 0x3448fa082a1329a7901ab4c2595f6955c11dd7e29fc127325fb95538ac662e32::suu {
    struct SUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUU>(arg0, 6, b"SUU", b"SUUFLEX", b"Journey of SUU to the Suuuuiii ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_23_at_20_44_24_d3c5d491d8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

