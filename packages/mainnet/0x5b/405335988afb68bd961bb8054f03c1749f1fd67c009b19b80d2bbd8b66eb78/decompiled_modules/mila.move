module 0x5b405335988afb68bd961bb8054f03c1749f1fd67c009b19b80d2bbd8b66eb78::mila {
    struct MILA has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MILA>, arg1: 0x2::coin::Coin<MILA>) {
        assert!(true == false, 100);
        0x2::coin::burn<MILA>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MILA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (true == true && 0x2::balance::supply_value<MILA>(0x2::coin::supply<MILA>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<MILA>>(0x2::coin::mint<MILA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MILA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILA>(arg0, 9, b"MILA", b"MILATOKEN", b"Super token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/6f98fN-c8DmeneWKaLNFqpwvF7IZtPgc3Mtyceuu1KU?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MILA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

