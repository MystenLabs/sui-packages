module 0xcfad407fa7e2b1c45f36854ff9380a8ad2c3020c0b3b7e84a03d73e1688d5514::little_mermaid {
    struct LITTLE_MERMAID has drop {
        dummy_field: bool,
    }

    fun init(arg0: LITTLE_MERMAID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LITTLE_MERMAID>(arg0, 9, b"LITTLE MERMAID", x"f09fa79ce2808de29980efb88f4c6974746c65204d65726d616964", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LITTLE_MERMAID>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LITTLE_MERMAID>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LITTLE_MERMAID>>(v1);
    }

    // decompiled from Move bytecode v6
}

