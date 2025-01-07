module 0x56312342c92e70ba1a3655bc6facfbd35b9cc822892f60a1e613bb2a750b05b8::aeon {
    struct AEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: AEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AEON>(arg0, 6, b"AEON", b"AEON1539", b"SUI-AEON1539", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snipaste_2024_10_14_08_31_32_a84512bb2a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AEON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AEON>>(v1);
    }

    // decompiled from Move bytecode v6
}

