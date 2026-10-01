module 0x5d481f579477cfca21913fbc51e2f705a26f66f11c6e2bd372439ad4509d2fcb::blast {
    struct BLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAST>(arg0, 9, b"Blast", b"Blast ", b"Clear for launch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipads.fun/api/files/suipump/logos/0x159ca760875b2e1713b7132559e0f50bc9e29a4e310816bc0683ab425ea814ce/8409678b-e8db-442d-a20f-bc48b377de4b.jpeg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLAST>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAST>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

