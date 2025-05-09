module 0x310da3fa1ac3d1f130542401c496821f2a8d45309a39812eff32c3d2f3e4acc2::spinda {
    struct SPINDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPINDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPINDA>(arg0, 6, b"SPINDA", b"POKEMON SPINDA", x"5370696e646120746865206472756e6b20506f6bc3a96d6f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifvfi5g5ppvh7t7oag6ipabxfewitxshlqyqhyvv7wxjcfuqciyxi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPINDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPINDA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

