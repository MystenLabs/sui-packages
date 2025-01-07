module 0x87038edb1e01f9a737c8a1d7377001f0015908839370b091ce9ea8ff9f72a0be::pol {
    struct POL has drop {
        dummy_field: bool,
    }

    fun init(arg0: POL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POL>(arg0, 6, b"POL", b"POLKY", b"LETS GO MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1080x360_a490d5c2a9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POL>>(v1);
    }

    // decompiled from Move bytecode v6
}

