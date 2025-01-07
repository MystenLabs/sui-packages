module 0x1fbab95f0fceeb68f640736b8b1ed43e4a7360816ab2a0abbfeb2f61d2c3fedd::kermit {
    struct KERMIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KERMIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KERMIT>(arg0, 9, b"KERMIT", b"Kermit On Sui", b"Kermit is meme on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1845088090907709440/jaqDy3qt.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KERMIT>(&mut v2, 210000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KERMIT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KERMIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

