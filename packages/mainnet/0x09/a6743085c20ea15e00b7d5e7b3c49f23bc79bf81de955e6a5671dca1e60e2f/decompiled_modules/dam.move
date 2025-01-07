module 0x9a6743085c20ea15e00b7d5e7b3c49f23bc79bf81de955e6a5671dca1e60e2f::dam {
    struct DAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAM>(arg0, 6, b"DAM", b"Sui Beaver", b"The most reliable DAM beaver on SUI. suibeaver.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1_55e14ce17c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

