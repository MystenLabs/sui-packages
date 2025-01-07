module 0x493ce5fe0fe566100906d83d97758d3b5c4f40812251930ebfc5e34e519dbbe0::puff {
    struct PUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF>(arg0, 9, b"PUFF", b"THE PUFF", b"the puff daddy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUFF>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

