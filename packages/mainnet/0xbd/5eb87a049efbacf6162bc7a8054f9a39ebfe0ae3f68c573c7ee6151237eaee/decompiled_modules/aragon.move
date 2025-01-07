module 0xbd5eb87a049efbacf6162bc7a8054f9a39ebfe0ae3f68c573c7ee6151237eaee::aragon {
    struct ARAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARAGON>(arg0, 9, b"ARAGON", b"Aqua Dragon", b"ARAGON IS MEME FIRST ON SUI CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1845134271322914816/Lfoap50-.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARAGON>(&mut v2, 669000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARAGON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARAGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

