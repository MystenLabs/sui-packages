module 0x5398788c872457420799421162e9c729e452bcff2ead09896e573273819227b0::apg {
    struct APG has drop {
        dummy_field: bool,
    }

    fun init(arg0: APG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APG>(arg0, 6, b"Apg", b"Aptos Gods", x"5468652066697273742066726565206d696e742070726f6a656374206f6e204170746f7320736f6c64206f757420696e206a757374203130207365636f6e64732120f09f9a80e29ca80a466972737420476f6473204d454d5320746f6b656e206973206e6f77206c697665206f6e205375692120e29aa1f09f8c900a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731178710352.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

