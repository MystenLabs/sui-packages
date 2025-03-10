module 0xbd6e10d212fc4c5ad3b36fd48718cc8d9c28d711d1090f403237dcaa91d1a498::aom {
    struct AOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AOM>(arg0, 9, b"AOM", b"AOM", b"from the northern region", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AOM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AOM>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

