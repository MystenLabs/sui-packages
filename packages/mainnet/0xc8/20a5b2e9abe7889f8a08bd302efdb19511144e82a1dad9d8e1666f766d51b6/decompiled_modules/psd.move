module 0xc820a5b2e9abe7889f8a08bd302efdb19511144e82a1dad9d8e1666f766d51b6::psd {
    struct PSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSD>(arg0, 6, b"PSD", b"Poseidon", b"In order to hope that sui can become the king", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_a_2024_10_02_ae_a_12_55_48_d2d6277683.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

