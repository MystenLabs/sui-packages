module 0x52ca11d0ba48e2c05949de5fecb8b8e4f90df86a02ac3bc6202c82fa27003cf::mark {
    struct MARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARK>(arg0, 9, b"Mark", b"Mark", b"The mark meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MARK>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

