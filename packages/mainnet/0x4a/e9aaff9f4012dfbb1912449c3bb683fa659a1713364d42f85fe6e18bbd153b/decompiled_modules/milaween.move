module 0x4ae9aaff9f4012dfbb1912449c3bb683fa659a1713364d42f85fe6e18bbd153b::milaween {
    struct MILAWEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILAWEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILAWEEN>(arg0, 6, b"Milaween", b"Sui Milaween", b"Dexscreener Paid : https://milaweenonsui.mom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo1_2_2_6af468b619.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILAWEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILAWEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

