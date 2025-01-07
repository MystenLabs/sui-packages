module 0x70f826a8a8f1c4df688a63301d7be2835a3ceadb90360f7bf58ccb594702978d::msi {
    struct MSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSI>(arg0, 9, b"MSI", b"Monkey SUI Inu", b"A monkey who never quits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWFrQTsVWXZePSeWu4oLSG9n938vtVsdeqrXHX7QJnREv")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MSI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

