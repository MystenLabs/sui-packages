module 0x6d05ece9a2124ecb4a1f2a5e50c9dd0e5a12e127da0ba13ba9c92e8384b48f98::hp {
    struct HP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HP>(arg0, 6, b"HP", b"hysalia physalis", b"Monkshood jellyfish inhabit the sea level, partly floating like a sail on the surface of the water and the rest underneath. They cannot generate power and move with the wind, currents and tides.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_1_e4f3d273b2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HP>>(v1);
    }

    // decompiled from Move bytecode v6
}

