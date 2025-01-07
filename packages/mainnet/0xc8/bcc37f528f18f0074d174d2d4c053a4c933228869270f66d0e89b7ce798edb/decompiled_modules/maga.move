module 0xc8bcc37f528f18f0074d174d2d4c053a4c933228869270f66d0e89b7ce798edb::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA>(arg0, 6, b"MAGA", b"MAGAS", x"4d414741202d205452554d5027532048415420535550504f5254205452554d5020535550504f5254204d4147410a4d414741206d616b6520616d657269636120677265617420616761696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MAGACAT_TG_9_Q_Zd_w1_G2s0cms8pq_565f9e42da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

