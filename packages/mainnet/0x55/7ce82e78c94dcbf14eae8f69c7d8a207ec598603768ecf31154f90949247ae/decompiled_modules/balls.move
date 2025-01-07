module 0x557ce82e78c94dcbf14eae8f69c7d8a207ec598603768ecf31154f90949247ae::balls {
    struct BALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLS>(arg0, 6, b"BALLS", b"Ballsagna", b"Who doesnt enjoy a nice plate of Ballsagna. Come grab a plate assholes!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/E2094_AE_9_CB_16_4_F56_B5_EA_9_FE_05_D58_B446_0639b5e584.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

