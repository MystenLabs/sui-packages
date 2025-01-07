module 0xeb7776daa9f1f3c6df7b5311e7a5226345bbf1bbe7cd7802893e5601ef052cee::aaafish {
    struct AAAFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAFISH>(arg0, 6, b"AAAFISH", b"AAA FISH", b"aaaaaaaaaaaaaaaaaaaaaaaaaaaFISHaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaSUIaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_09_30_04_27_18_4f239da247.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

