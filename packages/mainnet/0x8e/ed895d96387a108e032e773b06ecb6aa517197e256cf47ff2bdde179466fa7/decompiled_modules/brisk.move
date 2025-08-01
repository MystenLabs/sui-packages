module 0x8eed895d96387a108e032e773b06ecb6aa517197e256cf47ff2bdde179466fa7::brisk {
    struct TokenCreated has copy, drop {
        dummy_field: bool,
    }

    struct BRISK has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BRISK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BRISK>>(0x2::coin::mint<BRISK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BRISK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRISK>(arg0, 8, b"BRISK", b"BRISK SUIHUB-AFRICA", b"A Token For The Schools Of Thought.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://as2.ftcdn.net/jpg/02/89/66/43/1000_F_289664349_0jLyWIYGPOA88wlWaaYjsrH4oadeopQe.webp")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<BRISK>>(0x2::coin::mint<BRISK>(&mut v2, 30000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRISK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRISK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

