module 0x43dce6e08439a0cb53fbb3de6873f1969ecf4b6f6cc79f4130191aa11128ac7::moshaik {
    struct MOSHAIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOSHAIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOSHAIK>(arg0, 6, b"MOSHAIK", b"MOSHAIKSUI", b"BEST MOSHAIK ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MOSHAIK_bd31d5f541.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOSHAIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOSHAIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

