module 0xba6f200012a5916b9de17e98a10774d4046f5b054ff3f5a24b26ea2a5257d809::pull {
    struct PULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PULL>(arg0, 6, b"PULL", b"Mythical Pull", b"Mythical pull", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aa_8a4a07a173.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

