module 0x5abd8ef3c0da92b853c7b769b105b873ea43f2d8249ec2bfde7f61f0ada491a9::traimp {
    struct TRAIMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRAIMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRAIMP>(arg0, 9, b"TRAIMP", b"Trump Ai", b"First unofficial memecoin trained on Donald Trump life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1848771268708880384/kNayYmOf.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRAIMP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRAIMP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRAIMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

