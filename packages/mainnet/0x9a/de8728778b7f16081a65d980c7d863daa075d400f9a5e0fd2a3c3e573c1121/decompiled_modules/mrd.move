module 0x9ade8728778b7f16081a65d980c7d863daa075d400f9a5e0fd2a3c3e573c1121::mrd {
    struct MRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRD>(arg0, 6, b"MRD", b"MEMERAD", b"Memerad is more than just a token; it's a movement! Combining fun, community, and innovation, our goal is to connect memes with blockchain technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/memerad2_e13d9c7e30.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

