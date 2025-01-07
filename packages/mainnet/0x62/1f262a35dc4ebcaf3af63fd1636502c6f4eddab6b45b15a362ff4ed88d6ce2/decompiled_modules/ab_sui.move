module 0x621f262a35dc4ebcaf3af63fd1636502c6f4eddab6b45b15a362ff4ed88d6ce2::ab_sui {
    struct AB_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AB_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AB_SUI>(arg0, 9, b"AB SUI", b"AB SUI", b"AB SUIs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AB_SUI>(&mut v2, 323142141000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AB_SUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AB_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

