module 0xd12d2913ff9085e8909ea1303c8299168fa29b71bb94feaa2e282552cd17386f::reddog {
    struct REDDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: REDDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REDDOG>(arg0, 9, b"REDDOG", b"REDDOG", b"The richest dog in the world of memecoins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://red-dog.org/wp-content/uploads/2024/08/logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<REDDOG>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REDDOG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REDDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

