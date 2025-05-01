module 0x432d0a8139fd4c6b7b0237369ea6d8b843a9b106b9be8a4a8ce0d3c157570f2e::sm {
    struct SM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SM>(arg0, 9, b"SM", b"SUI MOON", b"sui to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/Cz75ZtjwgZmr5J1VDBRTm5ZybZvEFR5DEdb8hEy59pWq.png?size=xl&key=a36734")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SM>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SM>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SM>>(v1);
    }

    // decompiled from Move bytecode v6
}

