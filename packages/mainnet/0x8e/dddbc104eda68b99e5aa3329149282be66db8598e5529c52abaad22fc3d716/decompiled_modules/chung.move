module 0x8edddbc104eda68b99e5aa3329149282be66db8598e5529c52abaad22fc3d716::chung {
    struct CHUNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUNG>(arg0, 6, b"CHUNG", b"Evun Chung", b"Evun Chung iz an legen in teh crypto space, a master of none, nd teh kinda guy who probbly misplaced teh priv8 keys 2 ur wallet. But hey, hes here 2 lead teh way in teh memecoin revlulution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZW_3m8r_Wk_A_As_Nyq_ace5f0ae70.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHUNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

