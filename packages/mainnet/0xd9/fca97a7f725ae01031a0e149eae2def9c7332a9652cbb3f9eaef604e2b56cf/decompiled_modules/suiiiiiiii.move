module 0xd9fca97a7f725ae01031a0e149eae2def9c7332a9652cbb3f9eaef604e2b56cf::suiiiiiiii {
    struct SUIIIIIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIIIIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIIIIIII>(arg0, 6, b"SUIIIIIIII", b"SUIIIIII", x"4e6f207477656574732c206e6f206772616d2c206a75737420676f6174696e6720616e642070756d70200a0a535549494949494949494949494949", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5215488996849870917_ad4c8b4084.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIIIIIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIIIIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

