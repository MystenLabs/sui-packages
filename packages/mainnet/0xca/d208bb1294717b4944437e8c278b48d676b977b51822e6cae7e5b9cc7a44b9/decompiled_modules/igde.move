module 0xcad208bb1294717b4944437e8c278b48d676b977b51822e6cae7e5b9cc7a44b9::igde {
    struct IGDE has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<IGDE>, arg1: 0x2::coin::Coin<IGDE>) {
        assert!(false == false, 100);
        0x2::coin::burn<IGDE>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<IGDE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (false == true && 0x2::balance::supply_value<IGDE>(0x2::coin::supply<IGDE>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<IGDE>>(0x2::coin::mint<IGDE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: IGDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IGDE>(arg0, 5, b"IGDE", b"IGDE", b"Test coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/wKKMb7Ck_s2BrAk-CSEjtaUOtNncRDNLRsUfaxvHWLs?ext=png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IGDE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IGDE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

