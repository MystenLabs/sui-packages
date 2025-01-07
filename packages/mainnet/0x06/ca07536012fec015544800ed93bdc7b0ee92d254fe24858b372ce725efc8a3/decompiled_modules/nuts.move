module 0x6ca07536012fec015544800ed93bdc7b0ee92d254fe24858b372ce725efc8a3::nuts {
    struct NUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUTS>(arg0, 9, b"NUTS", b"Nuts", b"suck my nuts", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/4p5GVnMZYrwzp3qJfAenvcQVNzfCQxbd5QsRuRgvpump.png?size=xl&key=c882df")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NUTS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUTS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

