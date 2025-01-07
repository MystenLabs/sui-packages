module 0x2b0b9f6923ed741210571f4c6f78adc4daf267e50026086b96faa1190e81c755::ee {
    struct EE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EE>(arg0, 6, b"ee", b"reef3", b"wwqf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EE>>(v1);
    }

    // decompiled from Move bytecode v6
}

