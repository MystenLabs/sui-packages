module 0x3d767ef1a90e92130a368c5511b41c7143a3574c738ca61b0100472927842587::wa {
    struct WA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WA>(arg0, 6, b"WA", b"Wint", b"First Human Curated Terminal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_10_14_06_00_46_17476d8b4a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WA>>(v1);
    }

    // decompiled from Move bytecode v6
}

