module 0x5f8058670ecb5498124403de5c1b3c7b20067c492308632fe24d85d6c4f51ebe::tes {
    struct TES has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TES>, arg1: 0x2::coin::Coin<TES>) {
        assert!(false == false, 100);
        0x2::coin::burn<TES>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TES>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<TES>(0x2::coin::supply<TES>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<TES>>(0x2::coin::mint<TES>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TES>(arg0, 9, b"TES", b"TEST", b"TES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/i6hG20paO4daA3j2GjpesYAE8pdjg0ljtt1rKFp_wcU?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

