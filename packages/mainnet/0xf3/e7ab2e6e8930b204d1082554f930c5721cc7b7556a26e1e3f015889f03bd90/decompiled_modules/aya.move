module 0xf3e7ab2e6e8930b204d1082554f930c5721cc7b7556a26e1e3f015889f03bd90::aya {
    struct AYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AYA>(arg0, 6, b"AYA", b"America Ya", b"America Ya (Hallo Hallo Hallo) / Osaka In America, ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049451_72d4e71de8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

