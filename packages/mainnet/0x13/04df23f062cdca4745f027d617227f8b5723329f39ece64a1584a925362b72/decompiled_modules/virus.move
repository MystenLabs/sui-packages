module 0x1304df23f062cdca4745f027d617227f8b5723329f39ece64a1584a925362b72::virus {
    struct VIRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIRUS>(arg0, 9, b"VIRUS", b"Virus Coin", b"Virus On Sui : https://telegra.ph/Virus-Coin-On-Sui-10-09", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844031250983784448/_WycaNmZ.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VIRUS>(&mut v2, 600000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIRUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIRUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

