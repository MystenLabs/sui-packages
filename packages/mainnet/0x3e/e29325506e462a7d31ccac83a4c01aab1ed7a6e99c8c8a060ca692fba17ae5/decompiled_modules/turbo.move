module 0x3ee29325506e462a7d31ccac83a4c01aab1ed7a6e99c8c8a060ca692fba17ae5::turbo {
    struct TURBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBO>(arg0, 9, b"TURBO", b"Turbo", b"Turbo on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TURBO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

