module 0x190e8e57bbd7f4959cf86ca4abc969088c2a88d2db9ba05147b53f1ffe720dba::dacki {
    struct DACKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DACKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DACKI>(arg0, 9, b"DACKI", b"DACKI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeibcw7lwzyfretqhyuuravlmfy4xuv5z3vrdrve7k4dasnty46ps3i.ipfs.flk-ipfs.xyz")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DACKI>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DACKI>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DACKI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

