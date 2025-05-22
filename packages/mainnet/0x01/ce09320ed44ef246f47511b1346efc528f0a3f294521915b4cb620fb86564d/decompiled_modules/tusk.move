module 0x1ce09320ed44ef246f47511b1346efc528f0a3f294521915b4cb620fb86564d::tusk {
    struct TUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUSK>(arg0, 6, b"TUSK", b"TUSKARSUI", b"FIRST LAUNCHPAD IN WALRUS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieux7rq5rq7p2w73twc6xlx4inn23467eiemojai3ecdcuqbadsnm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TUSK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

