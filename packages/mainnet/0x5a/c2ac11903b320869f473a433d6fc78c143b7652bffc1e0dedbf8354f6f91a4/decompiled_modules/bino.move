module 0x5ac2ac11903b320869f473a433d6fc78c143b7652bffc1e0dedbf8354f6f91a4::bino {
    struct BINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINO>(arg0, 6, b"BINO", b"Binosaurus", b"BINO is not just another cryptocurrency; it's a complete ecosystem designed to power the future of decentralized finance. Built on cutting-edge blockchain technology, BINO offers unparalleled security, speed, and scalability.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/345cbb_a942071c69c548a0af73ff8564d67743_mv2_bb518ed09d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

