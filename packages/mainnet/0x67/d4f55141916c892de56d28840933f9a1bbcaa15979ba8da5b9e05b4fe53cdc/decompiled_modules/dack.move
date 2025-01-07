module 0x67d4f55141916c892de56d28840933f9a1bbcaa15979ba8da5b9e05b4fe53cdc::dack {
    struct DACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DACK>(arg0, 9, b"DACK", b"DACK", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeibcw7lwzyfretqhyuuravlmfy4xuv5z3vrdrve7k4dasnty46ps3i.ipfs.flk-ipfs.xyz")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DACK>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DACK>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DACK>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

