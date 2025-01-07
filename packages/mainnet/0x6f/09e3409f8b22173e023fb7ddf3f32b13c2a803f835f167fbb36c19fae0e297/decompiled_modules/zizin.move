module 0x6f09e3409f8b22173e023fb7ddf3f32b13c2a803f835f167fbb36c19fae0e297::zizin {
    struct ZIZIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIZIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIZIN>(arg0, 6, b"ZIZIN", b"Z I Z I N", b"ZIZIN is a fun and community-driven memecoin designed to bring humor and creativity to the crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9aaa355e_7c4c_46c8_9b6e_054623e56e7d_fe0b28bb42.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIZIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZIZIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

