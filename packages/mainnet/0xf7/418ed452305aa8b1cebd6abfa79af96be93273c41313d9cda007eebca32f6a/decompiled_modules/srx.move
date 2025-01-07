module 0xf7418ed452305aa8b1cebd6abfa79af96be93273c41313d9cda007eebca32f6a::srx {
    struct SRX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRX>(arg0, 6, b"SRX", b"sui rex", b"Something big and blue is coming  exclusively", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_dd4937b040.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRX>>(v1);
    }

    // decompiled from Move bytecode v6
}

