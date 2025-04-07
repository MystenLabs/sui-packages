module 0x914e1d8ddfa2fbcda39634e1d55bdbd8d17b2f0a487eafc0c9402919be677ef3::eth {
    struct ETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETH>(arg0, 9, b"WETH", b"ETH by Sui Bridge", b"Bridged Ether by Sui Bridge.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bridge-assets.sui.io/eth.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ETH>>(0x2::coin::mint<ETH>(&mut v2, 120000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ETH>>(v2);
    }

    // decompiled from Move bytecode v6
}

