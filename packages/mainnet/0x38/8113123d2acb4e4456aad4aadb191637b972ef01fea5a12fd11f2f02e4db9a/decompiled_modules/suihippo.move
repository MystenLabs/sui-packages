module 0x388113123d2acb4e4456aad4aadb191637b972ef01fea5a12fd11f2f02e4db9a::suihippo {
    struct SUIHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHIPPO>(arg0, 9, b"SUIHIPPO", b"HIPPOPOTASUI", b"https://t.me/hippopotasuiportal https://x.com/hippopotasui http://hippopotasui.xyz/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIHIPPO>(&mut v2, 235698744000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHIPPO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

