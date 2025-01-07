module 0xd45cbc4dedaf06c942272e277501c4aa5e8d1eb7ee81b0655e31894fa063cf1b::aaad {
    struct AAAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAD>(arg0, 6, b"AAAD", b"AAA Doge", b"AAA Doge - Can't stop Won't stop thinking about Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/VVVVV_16a81be2c2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

