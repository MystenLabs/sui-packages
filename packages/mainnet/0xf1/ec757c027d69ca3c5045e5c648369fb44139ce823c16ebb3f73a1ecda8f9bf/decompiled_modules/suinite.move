module 0xf1ec757c027d69ca3c5045e5c648369fb44139ce823c16ebb3f73a1ecda8f9bf::suinite {
    struct SUINITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINITE>(arg0, 6, b"SUINITE", b"Suigonite", b"From the days when Trainers carried their Game Boys in their pockets and dreamed of winged legends comes Suigonite  an epic fusion between the ancient power of Dragonite and the rapid innovation of the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiddimfwdam3e25r6vn5fbd5m6u5x4gg7j7opv33mp4tgolh6m7t5y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINITE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

