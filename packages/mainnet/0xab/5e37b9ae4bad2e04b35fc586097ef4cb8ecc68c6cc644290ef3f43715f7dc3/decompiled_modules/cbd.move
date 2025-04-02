module 0xab5e37b9ae4bad2e04b35fc586097ef4cb8ecc68c6cc644290ef3f43715f7dc3::cbd {
    struct CBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBD>(arg0, 6, b"Cbd", b"cryptobdarija", b"free palestine", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_A_l_A_chargement_2_afe952c7de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

