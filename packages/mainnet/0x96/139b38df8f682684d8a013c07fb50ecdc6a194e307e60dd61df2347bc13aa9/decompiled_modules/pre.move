module 0x96139b38df8f682684d8a013c07fb50ecdc6a194e307e60dd61df2347bc13aa9::pre {
    struct PRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRE>(arg0, 4, b"PRE", b"PRE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://premiumexchange.top/images/logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PRE>>(0x2::coin::mint<PRE>(&mut v2, 100000000000000, arg1), @0x6fb91c7423950d1b212bbbe913755bca502644cb73b0c5415b8fd3d0ad7b6d45);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PRE>>(v2);
    }

    // decompiled from Move bytecode v6
}

