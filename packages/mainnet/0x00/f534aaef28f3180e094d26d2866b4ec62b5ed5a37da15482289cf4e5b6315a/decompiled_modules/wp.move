module 0xf534aaef28f3180e094d26d2866b4ec62b5ed5a37da15482289cf4e5b6315a::wp {
    struct WP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WP>(arg0, 9, b"WP", b"Wrapped Plus", b"A wrapped token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WP>>(v1);
    }

    // decompiled from Move bytecode v6
}

