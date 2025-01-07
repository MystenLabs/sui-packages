module 0xf78f23aee870ec840204bed583099f8269ccfba6aaf4433aa5e7b9febc5d99df::fast {
    struct FAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAST>(arg0, 9, b"FAST", b"FAST", b"FASTESR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FAST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAST>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

