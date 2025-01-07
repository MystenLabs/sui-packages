module 0xf79885749e6636845e48e3c7a4391f7dda20657d61a233e4d8e35f27714ed340::sonkey {
    struct SONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONKEY>(arg0, 6, b"SONKEY", b"Sui Monkey", b"The Sui degen community was missing the wild energy of Solana's Ponke. Thats why they convinced ponke's brother - Sonkey - to join the ride. Meet this new iconic Sui character.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x3c5fdf0ee37d62c774025599e3b692d027746e24_0_00_00_00_ba421a7270.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

