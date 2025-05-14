module 0x6e7e64c2dcb85766d309aea3962deb3f266d05d3f65239dcd1515011fe75a79c::TwoB3D {
    struct TWOB3D has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TWOB3D>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TWOB3D>>(0x2::coin::mint<TWOB3D>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TWOB3D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWOB3D>(arg0, 9, b"2B3D", b"2B3D", b"2B3D.com: Blockchain sports games with player-owned assets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://2b3d.com/logo/2b3d-logo.png"))), arg1);
        let v2 = v0;
        let v3 = &mut v2;
        mint(v3, 1000000000000000000, @0x5ad44d17efba029a1b90163d3f1a338e1104ffeee5d6fc2b6383891b2c6a8024, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TWOB3D>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWOB3D>>(v2, @0x5ad44d17efba029a1b90163d3f1a338e1104ffeee5d6fc2b6383891b2c6a8024);
    }

    // decompiled from Move bytecode v6
}

