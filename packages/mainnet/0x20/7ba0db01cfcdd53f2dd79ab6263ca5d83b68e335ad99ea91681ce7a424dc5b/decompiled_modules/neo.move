module 0x207ba0db01cfcdd53f2dd79ab6263ca5d83b68e335ad99ea91681ce7a424dc5b::neo {
    struct NEO has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NEO>, arg1: 0x2::coin::Coin<NEO>) {
        assert!(true == false, 100);
        0x2::coin::burn<NEO>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NEO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (true == true && 0x2::balance::supply_value<NEO>(0x2::coin::supply<NEO>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<NEO>>(0x2::coin::mint<NEO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEO>(arg0, 5, b"NEO", b"NEO", b"NEO token on Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/dzw57ddvf_-uSO2zYYf_RB9wPaYDd0YcQnjHnPqlAyM")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

