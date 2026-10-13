module 0x3cb6aab9d191194b219c0fbfd2f7016dd41c3656f4be2edee6818dd4b9820644::mepe {
    struct MEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MEPE>(arg0, 6, 0x1::string::utf8(b"MEPE"), 0x1::string::utf8(b"Mysten Pepe"), 0x1::string::utf8(x"5065706520747269656420746f20756e6465727374616e64204d6f7665206c616e67756167652e204e6f77206865e2809973204d797374656e205065706520616e64206865e280997320756e73746f707061626c65"), 0x1::string::utf8(b"https://popularsui.xyz/media/db6f568f03c8c8cf2c78dc29038ab1a3cba1385e24a4832b78b60822602f16da.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEPE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MEPE>>(0x2::coin_registry::finalize<MEPE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

