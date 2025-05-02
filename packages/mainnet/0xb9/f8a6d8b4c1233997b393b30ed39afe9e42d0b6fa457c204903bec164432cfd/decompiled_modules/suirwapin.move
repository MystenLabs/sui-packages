module 0xb9f8a6d8b4c1233997b393b30ed39afe9e42d0b6fa457c204903bec164432cfd::suirwapin {
    struct SUIRWAPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRWAPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRWAPIN>(arg0, 9, b"SUIRWAPIN", b"RWA DePIN Protocol", b"RWA DePIN Protocol is the next-gen RWA-tokenized DePIN platform, redefining wealth management and the tokenization of real-world assets. Powered by SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.apeterminal.io/project/rwa_depin/icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIRWAPIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIRWAPIN>>(0x2::coin::mint<SUIRWAPIN>(&mut v2, 1109100000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIRWAPIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

