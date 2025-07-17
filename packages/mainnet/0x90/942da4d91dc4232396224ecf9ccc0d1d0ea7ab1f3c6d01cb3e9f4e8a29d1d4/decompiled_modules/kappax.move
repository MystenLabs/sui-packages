module 0x90942da4d91dc4232396224ecf9ccc0d1d0ea7ab1f3c6d01cb3e9f4e8a29d1d4::kappax {
    struct KAPPAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAPPAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAPPAX>(arg0, 6, b"KAPPAX", b"ROURUNI KAPPA X", b"KAPPAX isn't just another frog. this is a precision-strike meme with blood in its eyes. then watched the streets catch up. alpha chats lighting up. real meme guys clocking it.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihcaioglhcmq3txiiwexcxlcmhzapytysx7sq6bc4xv4gbco2mfvy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAPPAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAPPAX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

