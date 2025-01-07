module 0x581d0d8d800c8b0fd4bd6ac976577dab3b4487839ffb2f1c47553fc3d9386de4::yumi {
    struct YUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUMI>(arg0, 9, b"yumi", b"Sui Yumi", b"Yumi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmcdyhBCBAhkKPHA2UbazZmiZVFtrUbDWaBKSMNcudDk9i?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YUMI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUMI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

