module 0x1d046f8ad03333c33c206cdf3024c9af75fcfac077234682566c9d6f85f27c47::benny {
    struct BENNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENNY>(arg0, 6, b"BENNY", b"Benny The Bear", x"42656e6e792069732074686520666c7566666965737420706f6c6172206265617220796f75276c6c2065766572206d6565742c207769746820616e20697272657369737469626c7920726f756e642062656c6c79207065726665637420666f7220736e7567676c65732e0a4865206973206865726520746f20636f6e71756572204d6f766550756d702e0a4a6f696e2074686520636f6d6d756e69747920616e6420656e6a6f79207468652072696465210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Log_A_31339824ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BENNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

