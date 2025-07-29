module 0x507968376a92536aae258e084dce31536dbbf8160595b7d60fdb71fb0fc803a9::koko {
    struct KOKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOKO>(arg0, 6, b"KOKO", b"suikoko", b"Don't bother me,I'm \"KOKO\" now.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid62s3bkpeq4jm7qblgmn2dcpxsjrwsbxriydtk36kqiy33a25zqe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KOKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

