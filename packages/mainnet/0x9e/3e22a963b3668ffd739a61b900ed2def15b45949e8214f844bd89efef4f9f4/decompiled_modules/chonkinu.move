module 0x9e3e22a963b3668ffd739a61b900ed2def15b45949e8214f844bd89efef4f9f4::chonkinu {
    struct CHONKINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHONKINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHONKINU>(arg0, 6, b"CHONKINU", b"Chonk Inu", b"The chonkiest of all Shibas, bringing you fat gains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_12_111018_db1fa1d08d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHONKINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHONKINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

