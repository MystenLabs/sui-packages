module 0x8a0634c06d2a9c0f8ed8f2174d4565ddf143dad5b7c684a3650bb45f3ea9e62b::chf {
    struct CHF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHF>(arg0, 9, b"CHF", b"SUISSE", b"Official Swiss Coin Suisse!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.nationalflaggen.de/media/480/flagge-schweiz.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHF>(&mut v2, 8700000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHF>>(v1);
    }

    // decompiled from Move bytecode v6
}

