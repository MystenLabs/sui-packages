module 0x387ec772332b5c9c89d7beb38d089a41dd4c42c62904c54fa76ddbd348dd5ae9::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 6, b"PEPES", b"PEPESUI", b"PEPESUI Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://gateway.pinata.cloud/ipfs/QmSJoTmrSsxPYs3bH6U6oPgLGBrsCceMKtNYySVJ2xDY5M"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v0, @0xfb376d3d2282d556e7fc1a7a20af3394d89576f1633af6f078fcb36f53da2514);
    }

    public entry fun minto(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEPE>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

