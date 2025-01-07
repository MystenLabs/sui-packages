module 0xbc6edc8b5fd3666bfa5c1a0c77dbe2b3b55a018f601ea64f1d6209ef510017b5::star {
    struct STAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAR>(arg0, 6, b"STAR", b"Starfish Joe", b"Stick to the stars of the blockchain with StarfishJoey, the friendliest crypto on the reef.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2d_cartoon_dr_b3736933_efe1_4e5a_8ca1_0abe2489061a_346be01bbb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

