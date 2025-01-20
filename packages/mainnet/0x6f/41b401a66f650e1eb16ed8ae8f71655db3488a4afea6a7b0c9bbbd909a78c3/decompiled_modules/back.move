module 0x6f41b401a66f650e1eb16ed8ae8f71655db3488a4afea6a7b0c9bbbd909a78c3::back {
    struct BACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BACK>(arg0, 9, b"BACK", b"AMERICA IS BACK", b"AMERICA IS BACK LFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1757203362381168640/j9704gu__400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BACK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BACK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

