module 0x74e85ad7620b1e9b9c67da057c2cbd2c3ca3df186c0f91e5a310357ccd6b0930::mbappe {
    struct MBAPPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBAPPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBAPPE>(arg0, 6, b"Mbappe", b"Kylian Mbapp Lottin", b"Our Memecoin represents the greatest football player as well as the biggest Memecoin in the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_N_D_D_D_D_D_N_D_D_D_2024_10_03_D_22_24_59_f34a46b5c5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBAPPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MBAPPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

