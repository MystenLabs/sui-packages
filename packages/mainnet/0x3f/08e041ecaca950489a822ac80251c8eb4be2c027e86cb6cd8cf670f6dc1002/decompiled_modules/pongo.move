module 0x3f08e041ecaca950489a822ac80251c8eb4be2c027e86cb6cd8cf670f6dc1002::pongo {
    struct PONGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONGO>(arg0, 6, b"PONGO", b"Pongo On Sui", b"Pongo isn't just any skunk, he's warior born in the sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016563_c7c05ea2ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

