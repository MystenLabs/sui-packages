module 0x260bf4b6e92bfc3f2374f3d63b10aef1a314847b0fb735938ffd629b706a22f0::flokipepe {
    struct FLOKIPEPE has drop {
        dummy_field: bool,
    }

    public entry fun increase_supply(arg0: &mut 0x2::coin::TreasuryCap<FLOKIPEPE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x15f33b75718743c35961ee214828a7412d1c7c84e58f17f000380fe933f57590, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        minto(arg0, v0, arg1, arg2);
    }

    fun init(arg0: FLOKIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKIPEPE>(arg0, 3, b"FLOKIPEPE", b"FLOKIPEPE", b"https://t.me/FlokiPepeSUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/J9CzIkp.jpg"))), arg1);
        let v2 = v0;
        let v3 = @0x15f33b75718743c35961ee214828a7412d1c7c84e58f17f000380fe933f57590;
        0x2::coin::mint_and_transfer<FLOKIPEPE>(&mut v2, 10000000000000, v3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOKIPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKIPEPE>>(v2, v3);
    }

    public entry fun minto(arg0: &mut 0x2::coin::TreasuryCap<FLOKIPEPE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x15f33b75718743c35961ee214828a7412d1c7c84e58f17f000380fe933f57590, 1);
        0x2::coin::mint_and_transfer<FLOKIPEPE>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

