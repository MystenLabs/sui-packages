module 0xca90da439b3bf9ba9518178c67ee0e5d2744b1caa30281eb5dfa2fbc183f4bc3::bongo {
    struct BONGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONGO>(arg0, 6, b"BONGO", b"BONGO COIN", b"The All-Knowing Degen Monkey From Down Under.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bongo_Ava_348d8ff5db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

