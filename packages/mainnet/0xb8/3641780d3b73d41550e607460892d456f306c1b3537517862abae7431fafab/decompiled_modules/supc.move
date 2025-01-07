module 0xb83641780d3b73d41550e607460892d456f306c1b3537517862abae7431fafab::supc {
    struct SUPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPC>(arg0, 9, b"SUPC", b"SUP Master", b"SupXAirdrop community token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgdlvr.com/pic/photoresizer.com/20240928-1941/public")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUPC>(&mut v2, 23999962000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPC>>(v1);
    }

    // decompiled from Move bytecode v6
}

