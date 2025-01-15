module 0x2427f99b7039d729c083d2da182470101d2ae6f47cabd9b5c8c7d376255c740f::foceliza {
    struct FOCELIZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOCELIZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOCELIZA>(arg0, 6, b"FOCELIZA", b"FOCEliza", b"Open-source framework designed for fully on-chain AI agents/ ElizaOS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f81f8b25ce7dc13070f68f5a7f92bd7f3b4c2af629274ed6ae7d8bd810db387a_e6a3cc496e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOCELIZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOCELIZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

