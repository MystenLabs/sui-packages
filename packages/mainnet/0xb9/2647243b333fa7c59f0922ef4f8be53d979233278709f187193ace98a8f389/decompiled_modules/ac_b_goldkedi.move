module 0xb92647243b333fa7c59f0922ef4f8be53d979233278709f187193ace98a8f389::ac_b_goldkedi {
    struct AC_B_GOLDKEDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AC_B_GOLDKEDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AC_B_GOLDKEDI>(arg0, 6, b"ac_b_goldkedi", b"TicketForMEHMETkedi", b"Pre sale ticket of bonding curve pool for the following memecoin: MEHMETkedi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1777306322846851073/VunruzU2_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AC_B_GOLDKEDI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AC_B_GOLDKEDI>>(v2, @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AC_B_GOLDKEDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

