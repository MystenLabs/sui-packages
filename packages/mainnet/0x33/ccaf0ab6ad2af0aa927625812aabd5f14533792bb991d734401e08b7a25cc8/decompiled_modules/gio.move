module 0x33ccaf0ab6ad2af0aa927625812aabd5f14533792bb991d734401e08b7a25cc8::gio {
    struct GIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIO>(arg0, 6, b"GIO", b"Gio", b"Welcome to the one and only $GIO!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022410_7f1a1bfc31.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

