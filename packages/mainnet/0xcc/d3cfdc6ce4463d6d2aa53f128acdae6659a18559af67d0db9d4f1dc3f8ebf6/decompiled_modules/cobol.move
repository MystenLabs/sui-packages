module 0xccd3cfdc6ce4463d6d2aa53f128acdae6659a18559af67d0db9d4f1dc3f8ebf6::cobol {
    struct COBOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COBOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COBOL>(arg0, 9, b"COBOL", b"COBOL", b"The Program Language To Replace MOVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeiaw7becor6wyhjpg3b6is4w4w6frn4mu56u5h26cknkinvhu666gm.ipfs.dweb.link/COBOL.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COBOL>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COBOL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COBOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

