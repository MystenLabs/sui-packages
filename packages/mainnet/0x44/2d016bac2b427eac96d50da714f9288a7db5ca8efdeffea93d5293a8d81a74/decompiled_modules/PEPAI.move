module 0x442d016bac2b427eac96d50da714f9288a7db5ca8efdeffea93d5293a8d81a74::PEPAI {
    struct PEPAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPAI>(arg0, 8, b"PepAi", b"Sui Pepe Ai", b"PepAi combines the playful spirit of the original Pepe with a cutting-edge, tech-infused persona. This crypto token embodies the essence of decentralized finance with a futuristic twist.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmVnFZzUsD5a2fbM8CzMnsDiALXFktRtSo3oTpLFFkxCoL?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPAI>>(0x2::coin::mint<PEPAI>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPAI>>(v2);
    }

    // decompiled from Move bytecode v6
}

