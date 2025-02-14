module 0xb41f68f6f0fa0d9416737b913a814a23f01c54e43e53089b018a011549800254::kha {
    struct KHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KHA>(arg0, 9, b"Kha", b"Kha", b"Kha", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"Kha")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KHA>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KHA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KHA>>(v2);
    }

    // decompiled from Move bytecode v6
}

