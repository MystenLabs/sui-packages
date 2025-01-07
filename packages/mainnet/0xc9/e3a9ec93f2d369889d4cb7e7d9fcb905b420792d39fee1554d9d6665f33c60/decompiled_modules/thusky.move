module 0xc9e3a9ec93f2d369889d4cb7e7d9fcb905b420792d39fee1554d9d6665f33c60::thusky {
    struct THUSKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: THUSKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THUSKY>(arg0, 6, b"THusky", b"Thug Husky", b"Thug Husky is a memecoin in the Sui ecosystem, featuring a tough, street-style Siberian Husky character, combining both strength and humor. This memecoin is designed to capture attention with its lighthearted, meme-centric approach, backed by an enthusiastic community. Thug Husky leverages the popularity of meme culture and the charm of dog characters as its main appeal, making it an intriguing choice for speculative traders and crypto collectors who enjoy humor in their investments. As part of the Sui blockchain, Thug Husky offers the potential for fast transactions and low fees, ideal for active memecoin enthusiasts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241028_132011_2d6e0fefaa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THUSKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THUSKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

