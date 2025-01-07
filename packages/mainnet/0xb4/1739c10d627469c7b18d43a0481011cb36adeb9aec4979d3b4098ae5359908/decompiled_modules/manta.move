module 0xb41739c10d627469c7b18d43a0481011cb36adeb9aec4979d3b4098ae5359908::manta {
    struct MANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANTA>(arg0, 9, b"MANTA", b"MANTARAY", b"https://x.com/suimanta_https://x.com/suimanta_https://x.com/suimanta_https://x.com/suimanta_ https://x.com/suimanta_", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1836816316671610881/9gUseZbo_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MANTA>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANTA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

