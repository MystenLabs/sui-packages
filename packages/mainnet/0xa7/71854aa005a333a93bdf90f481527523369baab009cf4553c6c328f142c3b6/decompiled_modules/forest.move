module 0xa771854aa005a333a93bdf90f481527523369baab009cf4553c6c328f142c3b6::forest {
    struct FOREST has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FOREST>, arg1: 0x2::coin::Coin<FOREST>) {
        0x2::coin::burn<FOREST>(arg0, arg1);
    }

    fun init(arg0: FOREST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOREST>(arg0, 9, b"FOREST", b"FOREST", b"forest whispers secrets of time beyond time life beyond life decay, rebirth, eternal cycle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/BoAQaykj3LtkM2Brevc7cQcRAzpqcsP47nJ2rkyopump.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOREST>>(v1);
        0x2::coin::mint_and_transfer<FOREST>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FOREST>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FOREST>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FOREST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

