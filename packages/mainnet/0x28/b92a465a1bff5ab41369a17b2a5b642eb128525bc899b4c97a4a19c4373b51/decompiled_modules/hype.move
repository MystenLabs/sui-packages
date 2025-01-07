module 0x28b92a465a1bff5ab41369a17b2a5b642eb128525bc899b4c97a4a19c4373b51::hype {
    struct HYPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYPE>(arg0, 9, b"Hype", b"Hype", b"Hype1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://yt3.googleusercontent.com/ObZIQEeD69IWgJlPTwCgrgVZiIdnBZrRPjafrkNcqMCM_Ck-lNX49qL2tkNHhA17ZnHN1m1xjSg=s900-c-k-c0x00ffffff-no-rj")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HYPE>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

