module 0x8d3c1af3cdbd14709c0359a6f55b3909d5df42e14ae6785a0fa3a187f75006d5::paffy {
    struct PAFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAFFY>(arg0, 9, b"PAFFY", b"Paffy", b"Paffy is a fun, user-friendly token designed for easy transactions and broad accessibility. It supports community-driven governance and can be used across dApps, from gaming to DeFi, offering low fees and fast processing for a versatile experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1496444988242030593/XOtjNmK0.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAFFY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAFFY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

