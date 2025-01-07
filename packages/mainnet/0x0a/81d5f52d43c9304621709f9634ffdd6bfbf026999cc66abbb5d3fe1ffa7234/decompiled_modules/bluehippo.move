module 0xa81d5f52d43c9304621709f9634ffdd6bfbf026999cc66abbb5d3fe1ffa7234::bluehippo {
    struct BLUEHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEHIPPO>(arg0, 9, b"BLUEHIPPO", b"Blue Hippo", b"BlueHippo is meme on sui , Community : https://t.me/bluehipposui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1849574542458617857/myEfG94m.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUEHIPPO>(&mut v2, 366000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEHIPPO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

