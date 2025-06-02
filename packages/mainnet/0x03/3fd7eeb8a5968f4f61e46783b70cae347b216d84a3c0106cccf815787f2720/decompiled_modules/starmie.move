module 0x33fd7eeb8a5968f4f61e46783b70cae347b216d84a3c0106cccf815787f2720::starmie {
    struct STARMIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARMIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARMIE>(arg0, 6, b"STARMIE", b"Starmie on SUI", b"A wild Starmie appeared!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicqaqurmb2xpk4uvonfsn6d6b6kdqwvq7ulunbqzuiw4au6dohyma")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARMIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STARMIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

