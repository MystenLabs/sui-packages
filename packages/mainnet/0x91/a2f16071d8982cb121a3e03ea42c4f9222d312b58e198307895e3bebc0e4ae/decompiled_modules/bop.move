module 0x91a2f16071d8982cb121a3e03ea42c4f9222d312b58e198307895e3bebc0e4ae::bop {
    struct BOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOP>(arg0, 6, b"BOP", b"BOPCAT", x"24424f50204f4720426f7020436174212049206368616e6765206176617461722061732070657220746865206d657461210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F5hqdbyk_Xuksp8_P78_CA_Zen_Svp_P_Sh_AY_Kr_P2_U2_Mi_Z_Mdg_FN_336c7d1239.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

