module 0xfa92904e03673e17eaac0595fbb1ee6e650a3c48fdb631f7c773f53c2ccaf723::klo {
    struct KLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLO>(arg0, 6, b"KLO", b"klojh", b"klojh klojh klojh klojh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidfqr7vhruptof5x5zeaccsaxmywml2bngfybagaqp4wwrfv5ofkq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

