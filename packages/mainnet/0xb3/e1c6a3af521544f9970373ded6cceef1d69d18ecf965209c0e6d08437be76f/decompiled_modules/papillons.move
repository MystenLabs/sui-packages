module 0xb3e1c6a3af521544f9970373ded6cceef1d69d18ecf965209c0e6d08437be76f::papillons {
    struct PAPILLONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPILLONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPILLONS>(arg0, 6, b"Papillons", b"Papillon", b"Papillon to the moom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240927152258_3703435d10.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPILLONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAPILLONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

