module 0x57d03a1fa0dec52d8469a538bf5eef2f4e50c0e38f4d09c246d41091cdd57d23::scs {
    struct SCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCS>(arg0, 6, b"Scs", b"Simon's cat sui", b"Animation based meme project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022374_b0ec12286b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

