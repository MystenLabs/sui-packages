module 0x85e83a2f32524fce9c973a02add96bd7794217fd81a79ad2b427d48e83c09012::moonbucks {
    struct MOONBUCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONBUCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONBUCKS>(arg0, 6, b"MOONBUCKS", b"Moon bucks", x"4d6f6f6e204275636b732069732061206e6577206d656d62657220746f20746865204d656d6520616e6420416c7420436f696e0a436f6d6d756e697479202d206261736564206f6e2074686520536f6c616e6120426c6f636b636861696e2e20426f617374696e6720610a7374726f6e6720636f6d6d756e69747920616e642061207375627374616e7469616c206c697175696469747920706f6f6c2c204d6f6f6e0a4275636b732069732074686520666972737420736d616c6c207374657020696e2061206769616e74206c65617020746f77617264730a7265766f6c7574696f6e697a696e67207468652063727970746f63757272656e6379206c616e6473636170652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidw742zoms3xdknxkcrl35ici4pqjvc3wkjk7ahgkgwrqzmg6sd3u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONBUCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOONBUCKS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

