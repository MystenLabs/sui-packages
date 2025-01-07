module 0x35ca0a2aefcba4f6ba7eb1479b364a2bd362addbc294efeeb2ffefd391cb42e0::ssditzucciz {
    struct SSDITZUCCIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSDITZUCCIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSDITZUCCIZ>(arg0, 9, b"ssditzucciz", b"ssditzucciz7q", b"sgfizcd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSDITZUCCIZ>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSDITZUCCIZ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSDITZUCCIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

