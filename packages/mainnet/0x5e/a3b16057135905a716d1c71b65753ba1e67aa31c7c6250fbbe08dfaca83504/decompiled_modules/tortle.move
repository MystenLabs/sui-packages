module 0x5ea3b16057135905a716d1c71b65753ba1e67aa31c7c6250fbbe08dfaca83504::tortle {
    struct TORTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORTLE>(arg0, 6, b"TORTLE", b"Wartortle", x"426f726e2066726f6d20506f6bc3a96d6f6e2c206675656c6c6564206279206d656d65732c206275696c7420746f2073706c6173682e2020200a0a4e6f207574696c6974792c206a7573742076696265732e2053757266206f722073696e6b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigm5o2atsj66eb5aul2j2eyltvd4qm3me3msgfkqtv32xc7zvxtpe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TORTLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

