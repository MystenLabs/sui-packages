module 0x5108c617c86528ee757dc5bc04cbcbf0cfaaafde9200e59a9fa3c1291b6b0cf1::spicydog {
    struct SPICYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPICYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPICYDOG>(arg0, 9, b"SpicyDog", b"SpicyDog", b"The spicy dogo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPICYDOG>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPICYDOG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPICYDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

