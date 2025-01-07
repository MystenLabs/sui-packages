module 0xe3ba010bb6b72b7589d8ff2d14719d05d473c26c5fd27e2484276b6ba84c9247::gatto {
    struct GATTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GATTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GATTO>(arg0, 9, b"Gatto", b"Gatto", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GATTO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GATTO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GATTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

