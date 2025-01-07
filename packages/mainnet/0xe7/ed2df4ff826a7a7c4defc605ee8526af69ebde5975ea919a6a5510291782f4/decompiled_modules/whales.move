module 0xe7ed2df4ff826a7a7c4defc605ee8526af69ebde5975ea919a6a5510291782f4::whales {
    struct WHALES has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALES>(arg0, 9, b"WHALES", b"Sui Whales", b"Sui Whales Let's go To the Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1690733959146049536/Anq7NINt_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WHALES>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALES>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALES>>(v1);
    }

    // decompiled from Move bytecode v6
}

