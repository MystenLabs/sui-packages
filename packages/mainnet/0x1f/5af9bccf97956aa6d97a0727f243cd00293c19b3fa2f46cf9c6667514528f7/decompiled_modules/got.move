module 0x1f5af9bccf97956aa6d97a0727f243cd00293c19b3fa2f46cf9c6667514528f7::got {
    struct GOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOT>(arg0, 9, b"GOT", b"Gotlike", b"The god of goat passing by, no special powers. $GOT the almighty goat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

