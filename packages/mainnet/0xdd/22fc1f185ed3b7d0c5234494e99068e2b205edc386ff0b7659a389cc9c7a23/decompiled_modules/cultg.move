module 0xdd22fc1f185ed3b7d0c5234494e99068e2b205edc386ff0b7659a389cc9c7a23::cultg {
    struct CULTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULTG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CULTG>(arg0, 9, b"CULTK", b"Cult K", b"A Financial Network With Parallelized Performance. Building the most powerful decentralized financial ecosystem. Performant, accessible, and intuitive.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/HeLp6NuQkmYB4pYWo2zYs22mESHXPQYzXbB8n4V98jwC.png?size=lg&key=b380cb")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CULTG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<CULTG>>(0x2::coin::mint<CULTG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CULTG>>(v2);
    }

    // decompiled from Move bytecode v6
}

