module 0x543f0cd2bf951ffd238e50bbf54764c772ad86e785d536dd3f3d4626832e80ff::fisherman {
    struct FISHERMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHERMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHERMAN>(arg0, 6, b"FISHERMAN", b"Just a chill fisherman", x"41206669736865726d616e207769746820616e20616d626974696f6e206f66206361746368696e67207768616c6573206f6e205355492e0a50726573616c65206265666f726520436574757320506f6f6c21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_W9_QMZ_400x400_d739c3b14c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHERMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHERMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

