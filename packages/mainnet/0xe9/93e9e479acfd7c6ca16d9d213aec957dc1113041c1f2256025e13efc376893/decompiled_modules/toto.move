module 0xe993e9e479acfd7c6ca16d9d213aec957dc1113041c1f2256025e13efc376893::toto {
    struct TOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOTO>(arg0, 9, b"Toto", b"Toto", b"The toto token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOTO>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOTO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

