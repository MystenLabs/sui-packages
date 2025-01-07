module 0xba17ab84b5cbe59c3c75cc79ab047fa3240eb4888746f22668f4b4565a50cebf::dego {
    struct DEGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGO>(arg0, 6, b"DEGO", b"Sui Dego", b"Dego is a memecoin project built on the SUI blockchain, designed to bring innovation, creativity, and fun to the crypto space. It aims to engage the community and leverage the fast-growing SUI ecosystem as a foundation for its development.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241124_084542_8d52d3685c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

