module 0xd5f9a03604c47f726cd8974fe96686d03aafd5c1aaabb665074471eb4bed6492::spc {
    struct SPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPC>(arg0, 6, b"SPC", b"Sui phantom cat", b"MEOOOOWWWWW, from the heavens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000057944_f52d8b7688.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

