module 0x49dc9743c5e313f030d5f2b70e29143bc149a7417ba53b620b4d09a4dbe5fc5e::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 9, b"TRUMP", b"Trump 2024", b"Official token of Trump 2024.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://m.media-amazon.com/images/I/51U6C6xFHEL.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

