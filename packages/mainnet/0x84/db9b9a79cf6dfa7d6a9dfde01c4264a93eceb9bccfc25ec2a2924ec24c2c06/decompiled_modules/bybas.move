module 0x84db9b9a79cf6dfa7d6a9dfde01c4264a93eceb9bccfc25ec2a2924ec24c2c06::bybas {
    struct BYBAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYBAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYBAS>(arg0, 9, b"BYBAS", b"Babayagaga", b"babaya", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1938071fafd393d06bf96ff62c95f4fcblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BYBAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYBAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

