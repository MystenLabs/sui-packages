module 0xc9f814a5a588d8ac3c981771adb2eccc56d441ae5bf492fa0e1ddab03729fbfb::jak {
    struct JAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAK>(arg0, 6, b"JAK", b"SUIJAK", b"SUIJAK ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_23_22_38_fdc9ca708c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

