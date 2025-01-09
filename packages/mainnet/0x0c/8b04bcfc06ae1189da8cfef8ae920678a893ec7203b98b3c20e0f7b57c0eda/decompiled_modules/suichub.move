module 0xc8b04bcfc06ae1189da8cfef8ae920678a893ec7203b98b3c20e0f7b57c0eda::suichub {
    struct SUICHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHUB>(arg0, 6, b"SUICHUB", b"ChubbyFish on Sui", x"4661742066697368206c6f737420696e207468652053756920756e6976657273650a0a537569436875622c20612063687562627920666973682c206f6e652066696e65206461792c20776173206163636964656e74616c6c7920737765707420696e746f206120737061636520686f6c6520616e64206c6f737420696e2074686520636f6c6f7266756c2053756920626c6f636b636861696e20776f726c64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/new_1_9f4899efe2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

