module 0x2157187721149416601e87962f615f47a984901361a09ead47f55cec5369231b::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = if (0x1::vector::is_empty<u8>(&v0)) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<TOKEN>(arg0, 8, b"Ci PEPE", b"CPP", b"", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v3);
        0x2::coin::mint_and_transfer<TOKEN>(&mut v4, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v4, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v6
}

