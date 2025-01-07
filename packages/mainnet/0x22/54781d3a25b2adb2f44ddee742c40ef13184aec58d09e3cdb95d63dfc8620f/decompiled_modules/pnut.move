module 0x2254781d3a25b2adb2f44ddee742c40ef13184aec58d09e3cdb95d63dfc8620f::pnut {
    struct PNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUT>(arg0, 6, b"Pnut", b"Peanut The Squirrel", b"$PEANUT the Squirrel ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Nd_Tt_Jauw39u4_Dz_Gy_Ta_Z35r_Rx4_Vg_Axqb91w_E89zjy_H_Wd2_9e9a35099f.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

