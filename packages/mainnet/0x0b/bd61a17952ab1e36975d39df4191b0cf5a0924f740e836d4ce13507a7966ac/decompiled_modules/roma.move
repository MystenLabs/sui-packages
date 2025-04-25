module 0xbbd61a17952ab1e36975d39df4191b0cf5a0924f740e836d4ce13507a7966ac::roma {
    struct ROMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROMA>(arg0, 6, b"ROMA", b"Romatown", b"keep calm & tilt on", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihesw2t5izrgjbbz5gnf2y3sxxkwexzvsdzo6bzhaeshaudsnisyu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROMA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

