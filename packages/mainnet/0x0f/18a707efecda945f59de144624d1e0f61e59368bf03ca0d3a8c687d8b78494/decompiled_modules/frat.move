module 0xf18a707efecda945f59de144624d1e0f61e59368bf03ca0d3a8c687d8b78494::frat {
    struct FRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRAT>(arg0, 6, b"FRAT", b"FratSUI", b"Meet Frogg and Ratt. The 2 degens riding the Suinami", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/QZAH_7_Bu_C_400x400_11af9fc12d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

