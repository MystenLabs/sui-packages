module 0x172a2e24f951a4fb6f88feb43daf6bd3d75a2b848fa08483f52db763d36e0c62::sdmdr {
    struct SDMDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDMDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDMDR>(arg0, 6, b"SDMDR", b"Sui Diamond", x"31444d4452203d2031204361726174205265616c204469616d6f6e64200a54686520576f726c6427732031737420546f6b656e2062616b656420627920612031204361726174205265616c204469616d6f6e64207468617420796f752061637475616c6c79206f776e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d_Ywspw_W4_400x400_fdf55de411.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDMDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDMDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

