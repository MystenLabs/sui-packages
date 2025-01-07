module 0xc35801720d2f88f0b2c830bb024e3772c55bc22c8466431b91ca905c79918c5e::doggy {
    struct DOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGY>(arg0, 6, b"DOGGY", b"DOGGY", b"https://nftstorage.link/ipfs/bafkreicmeyyrddjewjnts47dlzuz6vaxoe4mvtxelrg6w5jxggx2f3ejhq", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGGY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DOGGY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

