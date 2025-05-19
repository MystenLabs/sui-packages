module 0xb7138c3d26e5615e9c8867d1c913bdaed9919c2a8b163d489e524611c2afbc4a::golduck {
    struct GOLDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDUCK>(arg0, 6, b"GOLDUCK", b"GOLDUCK SUI", b"Meet GOLDUCK, the Strongest Duck on SUI! GOLDUCK is more than just an adorable mascot it's a culture coin that is a symbol of innovation in the crypto space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic7mgexdwhgddnphtgbm4at5u5fhuxycfmmgwpjlpt2l3vt2ahowe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOLDUCK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

