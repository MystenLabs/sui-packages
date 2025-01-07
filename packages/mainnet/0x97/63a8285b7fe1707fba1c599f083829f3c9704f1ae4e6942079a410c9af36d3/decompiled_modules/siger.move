module 0x9763a8285b7fe1707fba1c599f083829f3c9704f1ae4e6942079a410c9af36d3::siger {
    struct SIGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIGER>(arg0, 9, b"SIGER", b"Sui Tiger", b"Pepe and Siger were close friends who always stuck together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmcB8WuwSiG9F6fCLYBHg84hX5SHCgN4DRMnkPMK9yAARX?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SIGER>(&mut v2, 2000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIGER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

