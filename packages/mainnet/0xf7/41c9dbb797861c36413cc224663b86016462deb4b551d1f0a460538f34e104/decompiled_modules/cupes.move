module 0xf741c9dbb797861c36413cc224663b86016462deb4b551d1f0a460538f34e104::cupes {
    struct CUPES has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUPES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUPES>(arg0, 6, b"Cupes", b"Cute Panda Sui", b"Cupes is a meme token on the Sui, we will use tokens as a medium of exchange.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/380eedd7_cf35_456e_aa4d_b7358eeff7ee_d3476e6104.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUPES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUPES>>(v1);
    }

    // decompiled from Move bytecode v6
}

