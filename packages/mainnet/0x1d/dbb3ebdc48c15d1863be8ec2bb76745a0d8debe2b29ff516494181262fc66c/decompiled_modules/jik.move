module 0x1ddbb3ebdc48c15d1863be8ec2bb76745a0d8debe2b29ff516494181262fc66c::jik {
    struct JIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIK>(arg0, 9, b"JIK", b"Jesus Is King", b"Jesus Loves You", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmT3DoyRA93svyByFCvWM6xDmQvgzqPKzY69oCDjfaJZ5T")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JIK>(&mut v2, 777777000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

