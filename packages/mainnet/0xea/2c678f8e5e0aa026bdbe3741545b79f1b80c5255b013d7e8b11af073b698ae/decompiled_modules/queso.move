module 0xea2c678f8e5e0aa026bdbe3741545b79f1b80c5255b013d7e8b11af073b698ae::queso {
    struct QUESO has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUESO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUESO>(arg0, 9, b"QUESO", b"Queso", b"A delicious token for all your cheesy needs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<QUESO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUESO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUESO>>(v1);
    }

    // decompiled from Move bytecode v6
}

