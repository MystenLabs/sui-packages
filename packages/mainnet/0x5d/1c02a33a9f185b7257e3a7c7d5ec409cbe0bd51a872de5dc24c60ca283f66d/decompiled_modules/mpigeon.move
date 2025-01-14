module 0x5d1c02a33a9f185b7257e3a7c7d5ec409cbe0bd51a872de5dc24c60ca283f66d::mpigeon {
    struct MPIGEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPIGEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPIGEON>(arg0, 6, b"MPigeon", b"Mammoth Pigeon", b"Mammoth had sex with a pigeon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_6_2d739d2e1d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MPIGEON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MPIGEON>>(v1);
    }

    // decompiled from Move bytecode v6
}

