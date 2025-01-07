module 0x2cd6493d5743c9ea0a6f887410abfcc06aad4d37c1ed1ba0cbafb992e467d5ab::sud {
    struct SUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUD>(arg0, 9, b"SUD", b"Sui degen", b"Degen only", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUD>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

