module 0xa3f58c1f35927a2ec664dfe5c7499db93660122a5d80f5904bd67f2d4958db20::trybethh {
    struct TRYBETHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRYBETHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRYBETHH>(arg0, 9, b"TRYBETHH", b"TRYBETHh", b"TRYBETH2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRYBETHH>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRYBETHH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRYBETHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

