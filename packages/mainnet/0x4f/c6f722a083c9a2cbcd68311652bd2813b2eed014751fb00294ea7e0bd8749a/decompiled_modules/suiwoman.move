module 0x4fc6f722a083c9a2cbcd68311652bd2813b2eed014751fb00294ea7e0bd8749a::suiwoman {
    struct SUIWOMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWOMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWOMAN>(arg0, 2, b"Suiwoman", b"Suiwoman", b"Suiman's chick", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIWOMAN>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWOMAN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWOMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

