module 0x4e83d2faaca4cba1cd337b19891e0d360ea874392228fc56e77c3bdf88e85346::halloween {
    struct HALLOWEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HALLOWEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HALLOWEEN>(arg0, 9, b"Halloween", b"Halloween", b"As you know, Halloween is coming soon. And this is a great time to create an event token. This year we became the first to do this.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://optim.tildacdn.pub/tild6361-6361-4461-b139-303462623538/-/resize/874x/-/format/webp/2024-10-15_194612.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HALLOWEEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HALLOWEEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HALLOWEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

