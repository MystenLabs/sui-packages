module 0x3dec1741c315202ee0ff51fa7ee174edd1d406b6f03c65a1c5a6651b0534abd2::suilana {
    struct SUILANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILANA>(arg0, 9, b"SUILANA", b"Suilana", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"Suilana")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUILANA>(&mut v2, 87635668000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILANA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

