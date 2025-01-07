module 0xe4ec221fd66c488fcf243e67caf38acd3f6ba8cb21de417d825fab47f2a0c5cc::boot {
    struct BOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOT>(arg0, 6, b"BOOT", b"DasBootCoin", b"Idea is to get the BOOT in the surface. DASBOOTCOIN is only all utility memecoin and nr.1 of SUI blockchain. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003992_d6a81736eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

