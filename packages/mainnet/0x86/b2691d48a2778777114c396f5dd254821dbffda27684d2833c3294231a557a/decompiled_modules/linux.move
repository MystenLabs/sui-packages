module 0x86b2691d48a2778777114c396f5dd254821dbffda27684d2833c3294231a557a::linux {
    struct LINUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINUX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LINUX>(arg0, 6, b"LINUX", b"Linux", b"Everywhere everytime and everythinh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052661_6c3c9f0e5c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LINUX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LINUX>>(v1);
    }

    // decompiled from Move bytecode v6
}

