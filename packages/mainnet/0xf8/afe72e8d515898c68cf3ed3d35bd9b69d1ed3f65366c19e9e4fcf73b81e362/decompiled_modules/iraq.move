module 0xf8afe72e8d515898c68cf3ed3d35bd9b69d1ed3f65366c19e9e4fcf73b81e362::iraq {
    struct IRAQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRAQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRAQ>(arg0, 9, b"iraq", b"iraq", b"damasc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IRAQ>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRAQ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IRAQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

