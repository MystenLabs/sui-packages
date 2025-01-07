module 0xf3351542ed85708eac76e4699ec2edd939f6bd83a63f4932f965e41b3b3d5ae1::smog {
    struct SMOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOG>(arg0, 6, b"SMOG", b"MOG going to SUI ($SMOG)", b"MOG represents effortless cosmic domination. MOG is tokenized victory.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rwn_Cv_TH_2_400x400_91b32dea6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

