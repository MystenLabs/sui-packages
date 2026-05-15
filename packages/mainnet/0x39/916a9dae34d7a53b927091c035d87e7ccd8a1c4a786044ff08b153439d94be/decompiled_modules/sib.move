module 0x39916a9dae34d7a53b927091c035d87e7ccd8a1c4a786044ff08b153439d94be::sib {
    struct SIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIB>(arg0, 9, b"SIB", b"Sui Is Back", b"Sui is back, the cycle resets, doubters fade and $SIB stands", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/L8mKRG6x/IMG-20260516-020046-302.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIB>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

