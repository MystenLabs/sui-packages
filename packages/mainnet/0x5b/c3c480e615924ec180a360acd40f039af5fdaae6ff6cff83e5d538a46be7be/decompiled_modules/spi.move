module 0x5bc3c480e615924ec180a360acd40f039af5fdaae6ff6cff83e5d538a46be7be::spi {
    struct SPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPI>(arg0, 6, b"SPI", b"Wing", x"77696e677320736f2065787472612c20697473206261736963616c6c7920696e20476f64206d6f6465200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/54_Fe_Sp1_Sy9jn_Ns_Px_Kpz_V_Pi_Kw1f_Vp_SK_Lb3v_Z5r_TJ_Tpump_d3b3b57bd7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

