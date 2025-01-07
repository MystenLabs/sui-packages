module 0xf636cb7d1d4e0685dc55d1bfb526c4f152d0a5962289ff499ab30d5f571ba3a9::bts {
    struct BTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTS>(arg0, 6, b"BTS", b"BARSIK", b"Hasbullas cat is living forever in the Solana blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5627_35190504de.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

