module 0x5877dcbbbd0be42d09c7c53e6c92d2788f621679541a035f96b0727f5a492542::putin {
    struct PUTIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUTIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUTIN>(arg0, 9, b"PUTIN", b"PUTIN", b"PUTIN Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUTIN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUTIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUTIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

