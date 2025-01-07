module 0x6822fa8845ce8dda2b7e8ae013c91eb85cdd3cee53286a4de075a3c7097780f3::mini {
    struct MINI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINI>(arg0, 6, b"Mini", b"Mini CTO", b"Mini Gang now on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8438_ca6a44d981.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINI>>(v1);
    }

    // decompiled from Move bytecode v6
}

