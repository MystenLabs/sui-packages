module 0x93a3b2cdf609169baa2df5e746f5b45ae0a64242f46fa7b4c7a66527d0e328c9::susdt {
    struct SUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSDT>(arg0, 6, b"sUSDT", b"Sui USDT", b"Sui meme USDT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/825_2eb5f04b8d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

