module 0x945a75c10c4040c11278f1dbcb0528d0da2947bcba5528800c0bed5b132c1462::bpug {
    struct BPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPUG>(arg0, 6, b"BPUG", b"BABY PUG", x"426f726e2066726f6d20746865204f472c2046756420746865205075672c0a244250554720697320726561647920746f20737465616c207468650a73706f746c69676874206f6e20537569212020576974682069747320637574650a627574206d697363686965766f757320636861726d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/L7_Jl37h4_400x400_b89f2b54cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

