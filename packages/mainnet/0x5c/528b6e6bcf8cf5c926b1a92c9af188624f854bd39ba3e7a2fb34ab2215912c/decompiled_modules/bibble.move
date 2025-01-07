module 0x5c528b6e6bcf8cf5c926b1a92c9af188624f854bd39ba3e7a2fb34ab2215912c::bibble {
    struct BIBBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBBLE>(arg0, 9, b"BIBBLE", b"BIBBLE", b"BIBBLE IS THE BEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIBBLE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBBLE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIBBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

