module 0x32e1afe45ddec1967c1bbb3a63c120968870b8c4bb92d9f1b13b8e2b6a0e36e2::marky {
    struct MARKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARKY>(arg0, 9, b"Marky", b"Marky", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MARKY>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

