module 0x86690c0a9c78681734d1e9abe25ac03a5929f2d0cbe144776ff7d21e8b7faba8::naruto {
    struct NARUTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NARUTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NARUTO>(arg0, 9, b"Naruto", b"Naruto", b"Dattebayo !!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NARUTO>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NARUTO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NARUTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

