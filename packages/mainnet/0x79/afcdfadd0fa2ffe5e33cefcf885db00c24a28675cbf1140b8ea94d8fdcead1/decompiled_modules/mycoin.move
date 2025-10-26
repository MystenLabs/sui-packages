module 0x79afcdfadd0fa2ffe5e33cefcf885db00c24a28675cbf1140b8ea94d8fdcead1::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: 0x2::coin::Coin<MYCOIN>) {
        0x2::coin::burn<MYCOIN>(arg0, arg1);
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYCOIN>(arg0, 9, b"Thaher.US", x"55d0854454", b"My custom token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bridge-assets.sui.io/usdt.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MYCOIN>(&mut v2, 100000001000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCOIN>>(v2, @0xdead);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MYCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
    }

    public fun transfer_ownership(arg0: 0x2::coin::TreasuryCap<MYCOIN>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYCOIN>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

