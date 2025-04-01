module 0x9ccdb3f51a4d110a3aa01df48d6d364845086c896c0286f7a5e290a7fe5cfb19::seedu {
    struct SEEDU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEDU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEDU>(arg0, 9, b"Seedu", b"SEED", x"46726f6d20612073696e676c6520534545442c206120756e6976657273652077617320626f726e2e200a0a4d696e6520534545443a2040736565645f636f696e5f626f740a0a583a20782e636f6d2f53656564436f6d62696e61746f720a436861743a20646973636f72642e67672f73656564676f0a466f7220706172746e6572736869703a2040616c657869737269676874", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8c1ab2f7e769dfef0aea83c292985a38blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEEDU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEDU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

