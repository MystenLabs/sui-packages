module 0xd64413180631b5dc9a9da237d6e2e4188b8106a2ff7b189227ec3ba654de96f1::chillz {
    struct CHILLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLZ>(arg0, 6, b"Chillz", b"Chillzard", b"Chillzard on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051214_481859a3f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

