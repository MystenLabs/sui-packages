module 0x244d3358ef3d6a1a911dc1530bd45210da6133fbd6adce780ab5937ed000cb99::sumo {
    struct SUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMO>(arg0, 6, b"Sumo", b"Suimo", b"Meet Suimo, a force of nature who defends our world with mastery over water. Raised with the honor and discipline of sumo, our hero blends power and peace, using immense strength to control the water elements and protect those in need.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031078_170773280f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

