module 0xcc3884101b02c6eeacf299d38ac537a126716a4c4910303ea9a29327f480b6ce::kkdd {
    struct KKDD has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<KKDD>, arg1: 0x2::coin::Coin<KKDD>) {
        assert!(false == false, 100);
        0x2::coin::burn<KKDD>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<KKDD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<KKDD>(0x2::coin::supply<KKDD>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<KKDD>>(0x2::coin::mint<KKDD>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: KKDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KKDD>(arg0, 5, b"KKDD", b"KKDD", b"djdjjdbbdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/P2GVPA_iNDgO5eX746ifBEM9uuM2-5LmKmZRMkezPh8?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KKDD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KKDD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

