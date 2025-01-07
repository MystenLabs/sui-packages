module 0xf566d9b9996dc0b28ab6943c6e55b570e69cdc11358a865a469890b255729e7d::e96969696 {
    struct E96969696 has drop {
        dummy_field: bool,
    }

    fun init(arg0: E96969696, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<E96969696>(arg0, 6, b"E96969696", b"696969", b"69", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/af8284e70a6abf864deb123ab05c8dc_aed1ed394a_a497ab097c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<E96969696>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<E96969696>>(v1);
    }

    // decompiled from Move bytecode v6
}

