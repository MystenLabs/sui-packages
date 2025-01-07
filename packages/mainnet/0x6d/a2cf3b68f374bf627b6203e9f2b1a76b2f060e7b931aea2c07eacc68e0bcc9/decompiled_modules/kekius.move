module 0x6da2cf3b68f374bf627b6203e9f2b1a76b2f060e7b931aea2c07eacc68e0bcc9::kekius {
    struct KEKIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEKIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEKIUS>(arg0, 9, b"KEKIUS", b"Kekius Maximus", b"Let the games begin by SUI Foundation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/5O9X9APvwUnkFOMkOFSMPC5BIalKKHgavQun5402Nno?ext=png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEKIUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<KEKIUS>>(0x2::coin::mint<KEKIUS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KEKIUS>>(v2);
    }

    // decompiled from Move bytecode v6
}

