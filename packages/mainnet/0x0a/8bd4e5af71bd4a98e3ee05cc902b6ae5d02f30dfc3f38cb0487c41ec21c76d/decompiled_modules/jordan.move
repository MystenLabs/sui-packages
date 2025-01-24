module 0xa8bd4e5af71bd4a98e3ee05cc902b6ae5d02f30dfc3f38cb0487c41ec21c76d::jordan {
    struct JORDAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JORDAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JORDAN>(arg0, 9, b"JORDAN", b"OFFICIAL JORDAN", b"Introducing $JORDAN, the ultimate tribute to the greatest of all time. Inspired by the legacy of Michael Jordan, this coin represents excellence, ambition, and the relentless pursuit of greatness.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNtMappdVAs3ZLUjC1PVbDdk2jzw5WhRmsLMnANRRgtug")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JORDAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JORDAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JORDAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

