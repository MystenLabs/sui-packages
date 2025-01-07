module 0x34ee5dc1c9088509e4cb97f794c0c4a835be55c8e7eae93c770c412af0d483c::kermit {
    struct KERMIT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KERMIT>, arg1: 0x2::coin::Coin<KERMIT>) {
        0x2::coin::burn<KERMIT>(arg0, arg1);
    }

    fun init(arg0: KERMIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KERMIT>(arg0, 9, b"KERMIT", b"Kermit", b"Kermit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcJNeXtfb6cRpoHHiu5P3YXNJKCw8KkmQQTojByqQUxh3")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KERMIT>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KERMIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KERMIT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

