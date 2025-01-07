module 0x8db62c16c921dbf334a7164a6d3887266ec90ae451e922f3a676a712b95af564::suiiiiiiiiii {
    struct SUIIIIIIIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIIIIIIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIIIIIIIII>(arg0, 6, b"SUIIIIIIIIII", b"SUIIIIIIIII", b"Ronaldo's Famous SUIIIIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DD_7_EBF_14_F661_4_BEB_8_E40_580087646_F26_6aa35da3e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIIIIIIIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIIIIIIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

