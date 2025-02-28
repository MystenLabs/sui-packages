module 0xdc002a78c974a116a4364f9e446bbc21d1865f605cbfea33b1c23012b85e5e38::bry {
    struct BRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRY>(arg0, 9, b"BRY", b"BryanCoin", b"A test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BRY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

