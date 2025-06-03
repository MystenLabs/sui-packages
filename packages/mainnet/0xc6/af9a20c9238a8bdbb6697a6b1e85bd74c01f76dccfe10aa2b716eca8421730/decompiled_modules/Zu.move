module 0xc6af9a20c9238a8bdbb6697a6b1e85bd74c01f76dccfe10aa2b716eca8421730::Zu {
    struct ZU has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ZU>, arg1: 0x2::coin::Coin<ZU>) {
        0x2::coin::burn<ZU>(arg0, arg1);
    }

    public fun increase_total_supply(arg0: &mut 0x2::coin::TreasuryCap<ZU>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZU>>(0x2::coin::from_balance<ZU>(0x2::balance::increase_supply<ZU>(0x2::coin::supply_mut<ZU>(arg0), arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: ZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZU>(arg0, 6, b"ZU", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ZU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

