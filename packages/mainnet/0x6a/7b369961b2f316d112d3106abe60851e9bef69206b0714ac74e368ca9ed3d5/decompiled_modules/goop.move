module 0x6a7b369961b2f316d112d3106abe60851e9bef69206b0714ac74e368ca9ed3d5::goop {
    struct GOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOP>(arg0, 6, b"Goop", b"GoopSui", b"Drippy, sticky, and full of surprises.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_065628795_7e0dc4edcc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

