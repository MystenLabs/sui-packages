module 0x14c16b40200883ccf44775cade2e64eea7c8ae56df9a898df9ea728c0389689::wee {
    struct WEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEE>(arg0, 6, b"WEE", b"WEE", b"WEE for test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEE>>(v1);
        0x2::coin::mint_and_transfer<WEE>(&mut v2, 10000000000000000, @0x3744c82e5038a5349d005c6a91dcc16accfe1f49654756248db7551b59b5ec26, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

