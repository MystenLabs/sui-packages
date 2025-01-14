module 0xd5d0d5c9c9feb5cdacb1f1c9371ac5d524129cfd8dc4fe73400e32c765428b51::blupa {
    struct BLUPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUPA>(arg0, 6, b"BLUPA", b"BLUE PANTHER", b"BLUPA is an entertainment memecoin of the Blue Panther Defi platform. Join us and lets add something really interesting to the digital SUI network together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo3_155b04dc17.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

