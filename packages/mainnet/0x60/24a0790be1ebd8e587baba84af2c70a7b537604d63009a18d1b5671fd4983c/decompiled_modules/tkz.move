module 0x6024a0790be1ebd8e587baba84af2c70a7b537604d63009a18d1b5671fd4983c::tkz {
    struct TKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKZ>(arg0, 6, b"TKZ", b"Tonkatsu", b"Tonkatsu Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tonkatsu2_32a21cce4d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

