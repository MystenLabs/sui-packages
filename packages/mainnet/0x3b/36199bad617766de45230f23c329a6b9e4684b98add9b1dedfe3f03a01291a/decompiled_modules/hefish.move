module 0x3b36199bad617766de45230f23c329a6b9e4684b98add9b1dedfe3f03a01291a::hefish {
    struct HEFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEFISH>(arg0, 6, b"HEFISH", b"Headcat fish", b"why i am here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_171558_8e0c318fd8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

