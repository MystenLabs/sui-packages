module 0xa69290f750c5f9aa176f7bcb92817818492d6885aa0a1d6ab0f78f8f9e35e41a::vibe {
    struct VIBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIBE>(arg0, 9, b"VIBE", b"VIBE", b"VIBE with me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VIBE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIBE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

