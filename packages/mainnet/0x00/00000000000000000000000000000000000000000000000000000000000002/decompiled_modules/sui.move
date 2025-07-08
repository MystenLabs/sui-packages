module 0x2::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<SUI> {
        assert!(0x2::tx_context::sender(arg0) == @0x0, 1);
        assert!(0x2::tx_context::epoch(arg0) == 0, 0);
        let v0 = SUI{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<SUI>(v0, 9, b"SUI", b"Sui", b"", 0x1::option::none<0x2::url::Url>(), arg0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI>>(v2);
        let v3 = 0x2::coin::treasury_into_supply<SUI>(v1);
        0x2::balance::destroy_supply<SUI>(v3);
        0x2::balance::increase_supply<SUI>(&mut v3, 10000000000000000000)
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<SUI>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

