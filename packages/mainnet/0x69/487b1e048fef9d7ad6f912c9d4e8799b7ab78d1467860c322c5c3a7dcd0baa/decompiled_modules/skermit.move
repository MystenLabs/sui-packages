module 0x69487b1e048fef9d7ad6f912c9d4e8799b7ab78d1467860c322c5c3a7dcd0baa::skermit {
    struct SKERMIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKERMIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKERMIT>(arg0, 9, b"SKERMIT", b"Sui Kermit", b"kermit on sui chain now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1845088090907709440/jaqDy3qt.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SKERMIT>(&mut v2, 440000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKERMIT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKERMIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

