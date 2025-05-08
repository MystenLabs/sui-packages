module 0x2904657862e245610e7b1af82bc2f7f54b60c0ae7f2037623535cfa57ad416ec::cb {
    struct CB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CB>(arg0, 9, b"CB", b"CHICKEN BANANA", b"CB CB CB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/FZRh6uAar3gEJb53ruHNjHibCPqiGHghfGiSRVeFpump.png?size=xl&key=4883a1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CB>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CB>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CB>>(v1);
    }

    // decompiled from Move bytecode v6
}

