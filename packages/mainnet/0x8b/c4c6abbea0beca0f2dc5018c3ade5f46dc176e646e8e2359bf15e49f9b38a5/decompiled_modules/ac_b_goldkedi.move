module 0x8bc4c6abbea0beca0f2dc5018c3ade5f46dc176e646e8e2359bf15e49f9b38a5::ac_b_goldkedi {
    struct AC_B_GOLDKEDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AC_B_GOLDKEDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AC_B_GOLDKEDI>(arg0, 6, b"ac_b_goldkedi", b"TicketForMEHMETkedi", b"Pre sale ticket of bonding curve pool for the following memecoin: MEHMETkedi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1777306322846851073/VunruzU2_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AC_B_GOLDKEDI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AC_B_GOLDKEDI>>(v2, @0x33b267e87bb2a27a2d0e38671052ba1f57d41912dca265709e68e12e00986591);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AC_B_GOLDKEDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

