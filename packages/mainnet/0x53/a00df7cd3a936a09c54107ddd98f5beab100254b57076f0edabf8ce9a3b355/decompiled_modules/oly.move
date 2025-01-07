module 0x53a00df7cd3a936a09c54107ddd98f5beab100254b57076f0edabf8ce9a3b355::oly {
    struct OLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLY>(arg0, 6, b"OLY", b"OLYMPICS", b"THE OLYMPIC GAMES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/j_WV_uo_QB_400x400_aea1aa3e42.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

