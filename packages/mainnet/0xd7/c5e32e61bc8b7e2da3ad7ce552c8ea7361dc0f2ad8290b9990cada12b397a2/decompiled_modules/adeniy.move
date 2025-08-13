module 0xd7c5e32e61bc8b7e2da3ad7ce552c8ea7361dc0f2ad8290b9990cada12b397a2::adeniy {
    struct ADENIY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADENIY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADENIY>(arg0, 9, b"ADENIY", b"ADN", b"ADENIY ON $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ADENIY>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADENIY>>(v2, @0xf129ff0022c360c932fb549dff4debb7285552dc737084268b57f9d26e06a3a3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADENIY>>(v1);
    }

    // decompiled from Move bytecode v6
}

