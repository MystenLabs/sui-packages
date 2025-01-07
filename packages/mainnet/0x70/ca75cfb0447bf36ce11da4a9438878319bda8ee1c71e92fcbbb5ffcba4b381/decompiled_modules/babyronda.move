module 0x70ca75cfb0447bf36ce11da4a9438878319bda8ee1c71e92fcbbb5ffcba4b381::babyronda {
    struct BABYRONDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYRONDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYRONDA>(arg0, 9, b"BABYRONDA", b"Baby Ronda", b"Ronda's baby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1837036267328131077/Ly43FPr6_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABYRONDA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYRONDA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYRONDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

