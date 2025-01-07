module 0xa74427117021a418c823abf1d66c9ddd6117140439eeaf70d53d30164023c1f9::sberry {
    struct SBERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBERRY>(arg0, 9, b"Sberry", b"Strawberry", b"The very delicious berry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SBERRY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBERRY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

