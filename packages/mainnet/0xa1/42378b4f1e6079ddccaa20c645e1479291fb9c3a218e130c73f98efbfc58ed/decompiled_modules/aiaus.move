module 0xa142378b4f1e6079ddccaa20c645e1479291fb9c3a218e130c73f98efbfc58ed::aiaus {
    struct AIAUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIAUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIAUS>(arg0, 9, b"AIAUS", b"AIA BERLIAN INTERNATIONAL", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://red-naval-pigeon-552.mypinata.cloud/ipfs/bafybeih65ilydkwe4b6fgdedvnjncz27zrnbmmwoqswjbf745447kw6flq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AIAUS>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIAUS>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AIAUS>>(v2);
    }

    // decompiled from Move bytecode v7
}

