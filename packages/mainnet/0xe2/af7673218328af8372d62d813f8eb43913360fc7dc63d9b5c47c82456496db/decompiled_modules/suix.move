module 0xe2af7673218328af8372d62d813f8eb43913360fc7dc63d9b5c47c82456496db::suix {
    struct SUIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIX>(arg0, 9, b"SUIX", b"SUI-X6900 (SPX)", b"Welcome to the SUI-X6900, an advanced blockchain cryptography token with limitless possibilities and scientific utilization. Imagine the power of the whole entire stock market put inside little tiny crypto coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://teal-deliberate-skunk-670.mypinata.cloud/ipfs/QmeeTTkxwGpMZN1CgggJSBhgFrvbiDqK4SJoJe3g5yhqS7")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

