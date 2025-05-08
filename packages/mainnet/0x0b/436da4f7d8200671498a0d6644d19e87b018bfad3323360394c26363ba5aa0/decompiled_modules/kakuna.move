module 0xb436da4f7d8200671498a0d6644d19e87b018bfad3323360394c26363ba5aa0::kakuna {
    struct KAKUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAKUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAKUNA>(arg0, 6, b"Kakuna", b"KAKUNASUI", b"Kakunasui soon fly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihfujivlfcky32vz7f7a5eoq2yznrz63oruntftdozkdyssxcibmq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAKUNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAKUNA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

