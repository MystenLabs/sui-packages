module 0x39534626c70d6c43221f992393bdac9f2c5bb137823faacb7fc9bac0f7782484::Shark {
    struct Registry has key {
        id: 0x2::object::UID,
        metadata: 0x2::coin::CoinMetadata<SHARK>,
    }

    struct SHARK has drop {
        dummy_field: bool,
    }

    struct Shark has store {
        start_date: u64,
        final_date: u64,
        original_balance: u64,
        balance: 0x2::balance::Balance<SHARK>,
    }

    fun init(arg0: SHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARK>(arg0, 9, b"vSUI", b"vSUI", b"Are you in the game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://archive.cetus.zone/assets/image/sui/vsui.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHARK>>(v1);
        0x2::coin::mint_and_transfer<SHARK>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARK>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHARK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!true, 1000);
        let v0 = 0x2::tx_context::sender(arg3);
        if (!(v0 == 0x2::tx_context::sender(arg3))) {
            let v1 = arg1 * 30 / 100;
            let v2 = arg1 - v1;
            let v3 = v2 * 20 / 100;
            assert!(v1 + v3 <= arg1, 0);
            0x2::coin::mint_and_transfer<SHARK>(arg0, v3, v0, arg3);
            0x2::coin::mint_and_transfer<SHARK>(arg0, v2 - v3, arg2, arg3);
        } else {
            0x2::coin::mint_and_transfer<SHARK>(arg0, arg1, arg2, arg3);
        };
    }

    // decompiled from Move bytecode v6
}

