module 0xe9834c925d4de056d9c6c6b2a14f4a91215e02197aaae04a5c23c482556419b7::crash {
    struct CRASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRASH>(arg0, 6, b"CRASH", b"CRASH TEST", b"Don't buy, you dummy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NMAH_ET_2010_28930_000002_47dbd21723.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

