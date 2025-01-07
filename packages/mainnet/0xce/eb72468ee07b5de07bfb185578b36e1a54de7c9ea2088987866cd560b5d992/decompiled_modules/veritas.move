module 0xceeb72468ee07b5de07bfb185578b36e1a54de7c9ea2088987866cd560b5d992::veritas {
    struct VERITAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VERITAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VERITAS>(arg0, 6, b"VERITAS", b"VERITAS SUI", b"the truth shall be revealed ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000351_513f8367be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VERITAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VERITAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

