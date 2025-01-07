module 0x774721c5bfc8fc87fd6f562b1b8c4808451678e755b88446507c4b25ebdf2de7::spam {
    struct SPAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPAM>(arg0, 6, b"SPAM", b"Proof Of SPAM", b"\"Spam to Earn\" a.k.a. \"Proof of Spam\" on Sui. Welcome to the community-owned page of $SPAM!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/K_Ee5v7_DZ_400x400_c2de0973bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

