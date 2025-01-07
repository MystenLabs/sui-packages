module 0x213507a7102acfb78aaa877fe1c883b785cf53e6f072a3dbce808daa57268ecf::ladys {
    struct LADYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LADYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LADYS>(arg0, 6, b"LADYS", b"LADYS on Sui", x"5468652031737420244c41445953206465706c6f796564206f6e205375692c20636f6d6d756e6974792d6d616e616765642e0a5468652068656972206170706172656e74202e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_O_O_U_U_O_U_8_11a2c1b1b0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LADYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LADYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

