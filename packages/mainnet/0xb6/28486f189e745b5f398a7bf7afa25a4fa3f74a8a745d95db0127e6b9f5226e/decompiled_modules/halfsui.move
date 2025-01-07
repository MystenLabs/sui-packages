module 0xb628486f189e745b5f398a7bf7afa25a4fa3f74a8a745d95db0127e6b9f5226e::halfsui {
    struct HALFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALFSUI>(arg0, 9, b"HalfSui", b"HalfSui", b"Half Sui Half Bag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/2YrBB5Q/photo-2024-10-04-23-17-42.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HALFSUI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALFSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

