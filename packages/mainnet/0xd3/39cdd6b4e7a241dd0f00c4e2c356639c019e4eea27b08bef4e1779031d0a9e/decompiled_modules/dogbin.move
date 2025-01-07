module 0xd339cdd6b4e7a241dd0f00c4e2c356639c019e4eea27b08bef4e1779031d0a9e::dogbin {
    struct DOGBIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGBIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGBIN>(arg0, 6, b"DOGBIN", b"01100100 01101111 01100111", b"Dog in Binary build only by 0 1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dog_A_9cf7c75d1b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGBIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGBIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

