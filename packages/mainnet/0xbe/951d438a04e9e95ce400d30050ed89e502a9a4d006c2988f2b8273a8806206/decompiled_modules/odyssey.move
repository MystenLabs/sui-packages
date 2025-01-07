module 0xbe951d438a04e9e95ce400d30050ed89e502a9a4d006c2988f2b8273a8806206::odyssey {
    struct ODYSSEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODYSSEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODYSSEY>(arg0, 6, b"ODYSSEY", b"SUI ODYSSEY", b"ODDYSEY PREPARED FOR BULLISH EXPEDITION IN SUI OCEAN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3904_58bdd09729.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODYSSEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ODYSSEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

