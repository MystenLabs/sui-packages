module 0x2a166d4523c8ffd9d3ffdde44985660937a4e5926697930e1d5991dd46aeee94::tate {
    struct TATE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TATE>, arg1: 0x2::coin::Coin<TATE>) {
        0x2::coin::burn<TATE>(arg0, arg1);
    }

    fun init(arg0: TATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATE>(arg0, 9, b"DADDY TATE", b"TATE", b"DADDY TATE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/4Cnk9EPnW5ixfLZatCPJjDB1PUtcRpVVgTQukm9epump.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TATE>>(v1);
        0x2::coin::mint_and_transfer<TATE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATE>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TATE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TATE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

