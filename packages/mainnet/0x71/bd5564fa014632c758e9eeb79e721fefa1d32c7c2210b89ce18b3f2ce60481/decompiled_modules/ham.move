module 0x71bd5564fa014632c758e9eeb79e721fefa1d32c7c2210b89ce18b3f2ce60481::ham {
    struct HAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAM>(arg0, 9, b"HAM", b"Hamster Kombat", b"Hamster Kombat Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HAM>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

