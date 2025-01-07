module 0xfc2a3274d7b1575415dd874594d361aa2f539c69129b53c90456feec58e75fc5::goldie {
    struct GOLDIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDIE>(arg0, 9, b"GOLDIE", b"AquaGold", b"AquaGold is hotty on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1840519950567424000/2dOGfFUH.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOLDIE>(&mut v2, 1300000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDIE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLDIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

