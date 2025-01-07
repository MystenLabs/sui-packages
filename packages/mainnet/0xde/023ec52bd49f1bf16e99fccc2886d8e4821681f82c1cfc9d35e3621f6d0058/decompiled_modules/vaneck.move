module 0xde023ec52bd49f1bf16e99fccc2886d8e4821681f82c1cfc9d35e3621f6d0058::vaneck {
    struct VANECK has drop {
        dummy_field: bool,
    }

    fun init(arg0: VANECK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VANECK>(arg0, 9, b"VanEck", b"One of the first U.S. Asset Managers", b"Leveraging Sui's trustworthy and battle-tested infrastructure, VanEck is bridging the gap between blockchain and traditional finance, offering millions of investors secure access to SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media.licdn.com/dms/image/v2/D560BAQH0ICw1Q_bB9A/company-logo_200_200/company-logo_200_200/0/1721198475133/vaneck_australia_logo?e=2147483647&v=beta&t=iyvE39N-g14DLGA_Rox6QfgZdu7T2QZDJmYNFn6h7hE")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VANECK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<VANECK>>(0x2::coin::mint<VANECK>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<VANECK>>(v2);
    }

    // decompiled from Move bytecode v6
}

