module 0x24c631600704defd9fbdbc8d6332dd869a22781a42cb95fa6c02fd2310afb5fa::suiby {
    struct SUIBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBY>(arg0, 6, b"SUIBY", b"Suiby-Doo", b"With Suiby-Doo tokens, you can join the gang in this thrilling new journey, where memes meet money, and mysteries turn into moonshots. Get ready to unleash the power of Suiby-Doo on Sui and watch as this playful coin takes the crypto world by storm!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_11_48_26_c1c62e7845.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

