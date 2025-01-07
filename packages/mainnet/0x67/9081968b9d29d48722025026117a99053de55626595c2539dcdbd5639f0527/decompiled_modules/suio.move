module 0x679081968b9d29d48722025026117a99053de55626595c2539dcdbd5639f0527::suio {
    struct SUIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIO>(arg0, 6, b"SUIO", b"Sui Otter", x"537569204f74746572206973206865726520746f206a6f696e206974732062726f74686572732046554420616e6420424c554220696e2074686973207375692062756c6c72756e0a0a245355494f20697320636f6d696e6720666f722074686520746f70", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_29_011756_006c4588cb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

