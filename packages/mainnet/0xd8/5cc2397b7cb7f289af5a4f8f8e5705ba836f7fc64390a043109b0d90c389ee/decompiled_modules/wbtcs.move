module 0xd85cc2397b7cb7f289af5a4f8f8e5705ba836f7fc64390a043109b0d90c389ee::wbtcs {
    struct WBTCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WBTCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WBTCS>(arg0, 9, b"wBTCS", b"Bitcoin (Wormwole)", b"BTC on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844057983158042624/XMq1Ot1f.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WBTCS>(&mut v2, 21000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WBTCS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WBTCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

