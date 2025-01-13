module 0x9b69972d0d7ecc5c9dec59efd9e6c7ed9081af2db9b0284ea2c74905080a2247::ghf {
    struct GHF has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GHF>, arg1: 0x2::coin::Coin<GHF>) {
        assert!(false == false, 100);
        0x2::coin::burn<GHF>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GHF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<GHF>(0x2::coin::supply<GHF>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<GHF>>(0x2::coin::mint<GHF>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GHF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHF>(arg0, 5, b"GHF", b"FGH", b"FGH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/CQWkGcHf4QxVSx3iFCXMwdbp6tJQJ5DQDdFdhyZ1xD0?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

