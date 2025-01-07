module 0x686302719345d81b51d301c60f77406bff379386a314a0cb0de76b367c5d32fb::doctor {
    struct DOCTOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOCTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOCTOR>(arg0, 6, b"Doctor", b"Dr. Sui", b"Doctor Sui loves to dominate other chains with his super powered Sui Belief", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1671513854_kalix_club_p_doktor_mankhetten_oboi_instagram_24_0089cfa2d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOCTOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOCTOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

