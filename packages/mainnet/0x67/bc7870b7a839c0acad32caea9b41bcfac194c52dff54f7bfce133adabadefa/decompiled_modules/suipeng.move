module 0x67bc7870b7a839c0acad32caea9b41bcfac194c52dff54f7bfce133adabadefa::suipeng {
    struct SUIPENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPENG>(arg0, 9, b"SUIPENG", b"Sui Peng", b"Penguin is first meme on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1845805794820022273/FxCd___T.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPENG>(&mut v2, 788000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPENG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

