module 0x8d39bdde17367e49cd5a013763cd29569b9dcf3e5d0b29e6d6752e68e09a1020::suipeng {
    struct SUIPENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPENG>(arg0, 6, b"SUIPENG", b"SUI PENG", x"492073686f756c646e742074616c6b20746f6f206d7563682061626f7574206d7973656c662c206a757374206b6e6f7720746861742049276d20676f696e6720746f2074616b6520746f20746f20746865206d6f6f6e2e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/q_Jx_Miv_Y13dr_Yix_H63_M1_Exw_RE_Kw_f5a209b5b7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

