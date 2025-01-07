module 0xc6031cf5a849b898c0375ba0b2f065b8d386767649bda5bafb02ca8eecd2847e::trial {
    struct TRIAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIAL>(arg0, 9, b"Trial", b"Trial", b"Triall", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRIAL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIAL>>(v2, @0x394a29f13a518801d253dd20d7e094ebc7fcc5982cd3e8d5d2c3a31f01f8cc01);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRIAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

