module 0x7c069e6f6d8a53bacaa85ede590abc50a2bffa432c8971a783f8d69b4e73c5b2::spearl {
    struct SPEARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEARL>(arg0, 6, b"SPEARL", b"SUI PEARL", b"SUI PEARL token is a digital asset on the SUI blockchain. It's used for transactions, staking, and governance within the SUI ecosystem. Think of it like a shiny pearl in the sea of cryptocurrencies!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240921_233058_591_9579500b36.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEARL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPEARL>>(v1);
    }

    // decompiled from Move bytecode v6
}

