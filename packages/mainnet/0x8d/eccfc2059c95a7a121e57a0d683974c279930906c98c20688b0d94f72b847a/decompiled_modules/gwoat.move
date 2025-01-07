module 0x8deccfc2059c95a7a121e57a0d683974c279930906c98c20688b0d94f72b847a::gwoat {
    struct GWOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GWOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GWOAT>(arg0, 6, b"GWOAT", b"GWOAT SUI", b"I am relentless gym bro and hustler that protects #SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/goat_1f88877140.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GWOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GWOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

