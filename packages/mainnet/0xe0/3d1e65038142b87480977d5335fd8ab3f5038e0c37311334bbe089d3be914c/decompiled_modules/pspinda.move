module 0xe03d1e65038142b87480977d5335fd8ab3f5038e0c37311334bbe089d3be914c::pspinda {
    struct PSPINDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSPINDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSPINDA>(arg0, 6, b"PSPINDA", b"POKEMON", x"5370696e646120746865206472756e6b20506f6bc3a96d6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifvfi5g5ppvh7t7oag6ipabxfewitxshlqyqhyvv7wxjcfuqciyxi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSPINDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PSPINDA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

