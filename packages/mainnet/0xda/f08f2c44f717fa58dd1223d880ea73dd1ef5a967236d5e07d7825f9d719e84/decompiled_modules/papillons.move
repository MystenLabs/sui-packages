module 0xdaf08f2c44f717fa58dd1223d880ea73dd1ef5a967236d5e07d7825f9d719e84::papillons {
    struct PAPILLONS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPILLONS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPILLONS>(arg0, 6, b"Papillons", b"Papillon", b"Papillon to the moom", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240927152258_3ef4e05680.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPILLONS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAPILLONS>>(v1);
    }

    // decompiled from Move bytecode v6
}

