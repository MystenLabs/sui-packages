module 0x35ac5ea24de04fbd657f5f00edf626351c5b1eb6f100895d1d322aca11a3bb40::big {
    struct BIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIG>(arg0, 6, b"BIG", b"Big", x"412042494720424f59206f6e20535549204e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_Adqjy1b_FH_5e_Lc1hx_Czdh_U_Ehgkj_RUZ_6j_HBN_6cumw_H_Qc4_1d0eb1dedf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

