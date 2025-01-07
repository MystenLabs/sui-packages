module 0xf7702d4baa60466a614f02bb266c01c3e336a0f3fecf73a6b730131028babf87::delon {
    struct DELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELON>(arg0, 9, b"DELON", b"Dark Elon", b"Dark hype", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DELON>(&mut v2, 110000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

