module 0x5115f6337ecb2bb5a4aa8f2c8662d862c7e866aef5405b7c15e3f37f9e698446::sheepe {
    struct SHEEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEEPE>(arg0, 2, b"Sheepe", b"Sheepe", b"Sheepe memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://st5.depositphotos.com/1719108/65446/i/450/depositphotos_654465622-stock-illustration-cartoon-scene-happy-cheerful-goat.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHEEPE>(&mut v2, 50000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEEPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

