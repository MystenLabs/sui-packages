module 0x75bab16871a74cfd0cc74ecfb1d498183a7a4fd708108d3e342457da58f9049::moodeng {
    struct MOODENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOODENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOODENG>(arg0, 9, b"MOODENG", b"Moo Deng", b"The cutest crypto you can buy?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1729247302641-76a461355ae8558ee87692f71b4d4103.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOODENG>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOODENG>>(v2, @0xbec39a3c5da974f18fd564a193e2b02ffa2177d265234657f999d9e50dc37c36);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOODENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

