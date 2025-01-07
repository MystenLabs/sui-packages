module 0x717d54c768ddf678e3e72357120c36e95e8fe64a7f1ce19caef062014090a6ee::dsl {
    struct DSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSL>(arg0, 9, b"DSL", b"Diego", b"memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://academy-public.coinmarketcap.com/srd-optimized-uploads/6c7bbb261f6844e6a0046b6f620f90de.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DSL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSL>>(v1);
    }

    // decompiled from Move bytecode v6
}

