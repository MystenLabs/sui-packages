module 0xc1f0af9e3ec424480e2d0b70b56106bb0bfca0150d3849a0a8a749f57bee827e::suimonster {
    struct SUIMONSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMONSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMONSTER>(arg0, 6, b"SUIMONSTER", b"Sui Monster", b"Cute but monstrous! Sui Monster is here to crush it on the Sui chain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Monster_d15b793ab3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMONSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMONSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

