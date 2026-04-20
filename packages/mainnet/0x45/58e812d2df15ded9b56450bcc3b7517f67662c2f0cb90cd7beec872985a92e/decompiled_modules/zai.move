module 0x4558e812d2df15ded9b56450bcc3b7517f67662c2f0cb90cd7beec872985a92e::zai {
    struct ZAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAI>(arg0, 9, b"ZAI", b"Zesh AI (Mintable)", b"Zesh is the first AI Layer on SUI that uses data model driven products to solve all of Web3's growth, marketing and community challenges.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1732100923231453184/n5YjbhvJ_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ZAI>>(0x2::coin::mint<ZAI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

