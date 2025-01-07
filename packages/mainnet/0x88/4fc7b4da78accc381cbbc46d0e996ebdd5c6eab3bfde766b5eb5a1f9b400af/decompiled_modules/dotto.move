module 0x884fc7b4da78accc381cbbc46d0e996ebdd5c6eab3bfde766b5eb5a1f9b400af::dotto {
    struct DOTTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOTTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOTTO>(arg0, 9, b"Dotto", b"Dotto", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOTTO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOTTO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOTTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

