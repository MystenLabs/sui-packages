module 0xfb138dfd682bafff26316d77bed627106962022f1b44168f5681ec9555232530::ripsui {
    struct RIPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIPSUI>(arg0, 6, b"RIPSUI", b"R.I.P SUI", b"No need all, Just RIP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_31_212445_4961c7b057.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

