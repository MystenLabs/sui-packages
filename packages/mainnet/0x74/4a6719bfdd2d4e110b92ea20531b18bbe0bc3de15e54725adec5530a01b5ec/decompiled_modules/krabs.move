module 0x744a6719bfdd2d4e110b92ea20531b18bbe0bc3de15e54725adec5530a01b5ec::krabs {
    struct KRABS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRABS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRABS>(arg0, 9, b"KRABS", b"Mr Krabs", b"Mr Krabs on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXMb5wGxUYY8sVCeomTgxpKEacGAkHrXSzTyAjdwGrNf6")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KRABS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRABS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRABS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

