module 0x85b7d05e1c94dff1a018a9d76806298a951a694c5025b491ba4559a67fa548a5::wok {
    struct WOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOK>(arg0, 9, b"WOK", b"Work", b"xzddd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

