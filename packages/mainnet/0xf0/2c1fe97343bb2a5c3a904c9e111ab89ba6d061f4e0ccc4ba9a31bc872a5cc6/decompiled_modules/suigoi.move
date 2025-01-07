module 0xf02c1fe97343bb2a5c3a904c9e111ab89ba6d061f4e0ccc4ba9a31bc872a5cc6::suigoi {
    struct SUIGOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGOI>(arg0, 9, b"SUIGOI", b"suigoi", b"suuuugoi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGOI>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

