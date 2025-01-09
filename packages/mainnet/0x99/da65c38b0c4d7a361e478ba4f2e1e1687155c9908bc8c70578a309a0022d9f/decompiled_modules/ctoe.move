module 0x99da65c38b0c4d7a361e478ba4f2e1e1687155c9908bc8c70578a309a0022d9f::ctoe {
    struct CTOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTOE>(arg0, 6, b"CTOE", b"Camel Toeken", x"4c65742773206d616b652043616d656c20546f6520477265617420416761696e21202443544f45206973207468652027746f65272d6b656e207468617420666c6970732074686520736372697074206f6e20626f6479207368616d696e6720616e642063656c6562726174657320636f6e666964656e63652077697468206120636865656b79207477697374210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_PK_9_Gt6_Vd_YSZ_6hoe7_DV_Pe7_Ew_M_Bm_Zm_G28i5iy_HJ_4x7_Mj_Qw_5b83fa576b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

