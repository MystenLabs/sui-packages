module 0xfd2d28e46d851af276e1763425df6ad2f4b9d98bd96ac148138e16813364051c::puff_dada {
    struct PUFF_DADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF_DADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF_DADA>(arg0, 9, b"PUFF DADA", b"PUFF DADA", b"plop on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUFF_DADA>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF_DADA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFF_DADA>>(v1);
    }

    // decompiled from Move bytecode v6
}

