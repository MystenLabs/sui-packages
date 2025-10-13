module 0x64f0f267a8a765519b2ca0f8735da2bb1f276aa97b14c62d867b2f9b22c540e2::BTC {
    struct BTC has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BTC>, arg1: 0x2::coin::Coin<BTC>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<BTC>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BTC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BTC>>(0x2::coin::mint<BTC>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<BTC>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BTC>>(arg0);
    }

    fun init(arg0: BTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTC>(arg0, 9, b"BTC", b"BitcoinSui", b"Bitcoin is now on SUI, all you need to do is hold BTC and earn rewards. Can we go higher than BTC? Only time will tell", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suirewards.me/coinphp/uploads/img_68ec554827de02.95631481.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

