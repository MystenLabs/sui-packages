module 0x3557952c9c43fdabfce78ebd49812bcd91028e9dc16288bac25f0c0805b290e9::mikyu {
    struct MIKYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKYU>(arg0, 6, b"Mikyu", b"Mimikyu", x"546865204c6f6e656c6965737420506f6bc3a96d6f6e206f6e20537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiemxnqbb3ocgfdgnox74pnb4d3hhcdyl3v6ek2l5stmdyaa55e3li")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MIKYU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

