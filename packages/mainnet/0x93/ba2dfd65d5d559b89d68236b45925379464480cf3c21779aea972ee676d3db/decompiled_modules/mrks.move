module 0x93ba2dfd65d5d559b89d68236b45925379464480cf3c21779aea972ee676d3db::mrks {
    struct MRKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRKS>(arg0, 9, b"MRKS", b"Markowski", b"nft", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d8323b989c2bd3e1177d4eb4466f0f71blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRKS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRKS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

