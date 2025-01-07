module 0xc1b2b20455edfa20c053da868be94b4d7f4b345b22bac7a7ebd8bd7a3df61cde::eth {
    struct ETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETH>(arg0, 6, b"ETH", b"Ethereum on SUI", b"Ethereum, but fast and no gas. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0051_8436d5aea1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

