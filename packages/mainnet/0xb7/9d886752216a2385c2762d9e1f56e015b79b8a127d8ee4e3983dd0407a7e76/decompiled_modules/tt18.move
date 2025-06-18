module 0xb79d886752216a2385c2762d9e1f56e015b79b8a127d8ee4e3983dd0407a7e76::tt18 {
    struct TT18 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT18, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT18>(arg0, 6, b"TT18", b"Token Test 18/6 11:40", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/720a3bef-cef3-4e7b-86b1-f969531cc786.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TT18>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT18>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TT18>>(v1);
    }

    // decompiled from Move bytecode v6
}

