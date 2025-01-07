module 0xa1717f400c44b9c4b063c39a2ea1bd4bf0b8f27248ba58763f406307d850b444::bobe {
    struct BOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBE>(arg0, 6, b"BOBE", b"Bobe On Sui", x"0a24424f42452054686520556e69636f726e20446f672e20546865206b696e6465737420616e642067656e65726f757320646f6720796f756c6c2065766572206d656574", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000257_8a7ed7b809.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

