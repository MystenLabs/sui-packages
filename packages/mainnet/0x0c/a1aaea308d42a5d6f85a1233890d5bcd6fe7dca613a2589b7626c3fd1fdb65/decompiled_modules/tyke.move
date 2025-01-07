module 0xca1aaea308d42a5d6f85a1233890d5bcd6fe7dca613a2589b7626c3fd1fdb65::tyke {
    struct TYKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYKE>(arg0, 6, b"TYKE", b"Tyke Sui", b"Tike is the bulldog spike's son in cartoon tom and jerry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002551_1ff2c215d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TYKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

