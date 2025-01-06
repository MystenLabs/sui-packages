module 0xc40b645454ea7a2d1da6086aaed7be94a37502bd0b4da6b18ba1cb677d7fa633::pc {
    struct PC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PC>(arg0, 6, b"PC", b"Pringles Cat", b"Who needs chips when you have this purr-fect little surprise in the can?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2065152_83bfab6792.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PC>>(v1);
    }

    // decompiled from Move bytecode v6
}

