module 0xcd1b6e3af6c7c84bb04b1c6d35d4975b37dce0023271a6ec1042bde7938f662c::edvard {
    struct EDVARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDVARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDVARD>(arg0, 6, b"EDVARD", b"Edvard Munching", b"Munching ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030720_0297c03e1a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDVARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDVARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

