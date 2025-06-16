module 0x917a0d05a707b10588a5006fa74e9ae680682ae0455a3e6638c47cc8db3a93e9::moonpig {
    struct MOONPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONPIG>(arg0, 6, b"MOONPIG", b"Moonpig Sui", b"Moonpig on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih73msysktpjrovt4ewbiyuafh5vtgkq7u2vwinx5s4i6oeclwp6y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONPIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOONPIG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

