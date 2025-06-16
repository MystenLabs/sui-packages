module 0x153c045256304f2288838a8356ef6ac05055455d555968aa45c459b023fe28b::catzo {
    struct CATZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATZO>(arg0, 6, b"CATZO", b"Catzo Sui", b"Catzo is a hero cat who has super powers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiclgmw5fg5lj375v3vrojmbk2v6hngtjdpe4rkr62zakwwgmitjzy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATZO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

