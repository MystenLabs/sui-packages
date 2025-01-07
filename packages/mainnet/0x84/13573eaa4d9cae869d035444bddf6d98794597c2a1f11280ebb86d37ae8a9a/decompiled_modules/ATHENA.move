module 0x8413573eaa4d9cae869d035444bddf6d98794597c2a1f11280ebb86d37ae8a9a::ATHENA {
    struct ATHENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATHENA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATHENA>(arg0, 9, b"ATHena", b"Project Athena", b"The Official Unofficial Sui Mascot. The First Meme Fair Launch Platform on SUI Network. We are bullish on the future of the Sui. To the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdnb.artstation.com/p/assets/images/images/081/018/387/large/yuliya-velychko-yuliya-velychkoathina3.jpg?1729154921")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATHENA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ATHENA>>(0x2::coin::mint<ATHENA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ATHENA>>(v2);
    }

    // decompiled from Move bytecode v6
}

