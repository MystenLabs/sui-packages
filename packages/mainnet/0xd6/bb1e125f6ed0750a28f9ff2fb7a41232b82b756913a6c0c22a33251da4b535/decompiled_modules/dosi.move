module 0xd6bb1e125f6ed0750a28f9ff2fb7a41232b82b756913a6c0c22a33251da4b535::dosi {
    struct DOSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOSI>(arg0, 6, b"DOSI", b"Dog Sui", b"The first Huski dog on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_HTP_Cr_X_400x400_012715331b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

