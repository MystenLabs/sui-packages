module 0x9235fafd138edd299d267ece4a77492b5f1e33b719db98a35ca7b159b631a124::maximus {
    struct MAXIMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAXIMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAXIMUS>(arg0, 9, b"MAXIMUS", b"Kekius Maximus", b"Elon the Kekius Maximus !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQniYkFR1KU7SgwwDHfC96kfwYKHB6VzETv9r8z56ViRz")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAXIMUS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAXIMUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAXIMUS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

