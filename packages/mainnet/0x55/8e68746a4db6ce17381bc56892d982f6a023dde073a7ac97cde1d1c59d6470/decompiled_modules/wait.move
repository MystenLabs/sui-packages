module 0x558e68746a4db6ce17381bc56892d982f6a023dde073a7ac97cde1d1c59d6470::wait {
    struct WAIT has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WAIT>, arg1: 0x2::coin::Coin<WAIT>) {
        assert!(true == false, 100);
        0x2::coin::burn<WAIT>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WAIT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (true == true && 0x2::balance::supply_value<WAIT>(0x2::coin::supply<WAIT>(arg0)) != 0) {
            abort 100
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<WAIT>>(0x2::coin::mint<WAIT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: WAIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAIT>(arg0, 7, b"WAIT", b"WAIT on sui", b"Wait is a youtube viral with over 800k+ views", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.arweave.net/O-q6qPz4tjT11wQ6yFt_dJvCdXmuNpUf9PAj8cJEOx0?ext=jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

