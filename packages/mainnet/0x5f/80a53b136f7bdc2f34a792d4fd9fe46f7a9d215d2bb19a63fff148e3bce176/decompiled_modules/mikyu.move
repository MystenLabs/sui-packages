module 0x5f80a53b136f7bdc2f34a792d4fd9fe46f7a9d215d2bb19a63fff148e3bce176::mikyu {
    struct MIKYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKYU>(arg0, 6, b"Mikyu", b"Mimikyu", b"The Loneliest Pokemon on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiemxnqbb3ocgfdgnox74pnb4d3hhcdyl3v6ek2l5stmdyaa55e3li")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MIKYU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

