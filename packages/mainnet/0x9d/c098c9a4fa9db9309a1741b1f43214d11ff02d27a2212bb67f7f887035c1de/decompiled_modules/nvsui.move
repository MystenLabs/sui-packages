module 0x9dc098c9a4fa9db9309a1741b1f43214d11ff02d27a2212bb67f7f887035c1de::nvsui {
    struct NVSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NVSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NVSUI>(arg0, 9, b"nvSui", b"Novel Sui", b"Novel Finance Stablecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NVSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NVSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NVSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

