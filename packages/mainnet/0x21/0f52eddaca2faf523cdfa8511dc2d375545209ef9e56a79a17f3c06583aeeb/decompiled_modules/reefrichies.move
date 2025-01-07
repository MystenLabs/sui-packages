module 0x210f52eddaca2faf523cdfa8511dc2d375545209ef9e56a79a17f3c06583aeeb::reefrichies {
    struct REEFRICHIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: REEFRICHIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REEFRICHIES>(arg0, 8, b"REEFRICHIES", b"ReefRiches ", b"gema", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoMKnUSUIZV8RzvDtbeUrRCBjYIDZVNXjIPlC0uk5KYg&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<REEFRICHIES>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REEFRICHIES>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REEFRICHIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

