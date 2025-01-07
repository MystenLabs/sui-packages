module 0x661bfbca95d86813558a16abf9dadc37fcc93fc3e229e2136ed163f427e8e614::esos {
    struct ESOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESOS>(arg0, 6, b"ESOS", b"Elon Shoot on SUI", x"54686520526967687420746f20426561722041726d730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gd_H_Bz_Rv_Xo_AA_1_Z76_932eb17930.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ESOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

