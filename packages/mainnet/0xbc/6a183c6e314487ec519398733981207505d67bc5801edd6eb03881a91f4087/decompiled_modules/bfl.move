module 0xbc6a183c6e314487ec519398733981207505d67bc5801edd6eb03881a91f4087::bfl {
    struct BFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFL>(arg0, 6, b"BFL", b"buffalo", b"have buff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_22_231919_7db1d87c51.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BFL>>(v1);
    }

    // decompiled from Move bytecode v6
}

