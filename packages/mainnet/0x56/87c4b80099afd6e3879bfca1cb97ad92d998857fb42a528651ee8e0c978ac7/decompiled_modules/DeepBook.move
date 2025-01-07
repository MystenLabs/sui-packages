module 0x5687c4b80099afd6e3879bfca1cb97ad92d998857fb42a528651ee8e0c978ac7::DeepBook {
    struct Registry has key {
        id: 0x2::object::UID,
        metadata: 0x2::coin::CoinMetadata<DEEPBOOK>,
    }

    struct DEEPBOOK has drop {
        minting_disabled: bool,
    }

    struct DeepBook has store {
        start_date: u64,
        final_date: u64,
        original_balance: u64,
        balance: 0x2::balance::Balance<DEEPBOOK>,
    }

    fun init(arg0: DEEPBOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPBOOK>(arg0, 9, b"DEEPBOOK", b"DEEPBOOK", b"DeepBook is in the game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://images.deepbook.tech/icon.svg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEEPBOOK>>(v1);
        0x2::coin::mint_and_transfer<DEEPBOOK>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPBOOK>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DEEPBOOK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 * 5 / 100;
        let v1 = arg1 - v0;
        let v2 = v1 * 5 / 100;
        let v3 = v1 - v2;
        let v4 = v3 * 10 / 100;
        assert!(v0 + v2 + v4 <= arg1, 0);
        let v5 = 0x2::tx_context::sender(arg3);
        0x2::coin::mint_and_transfer<DEEPBOOK>(arg0, v4, v5, arg3);
        0x2::coin::mint_and_transfer<DEEPBOOK>(arg0, v3 - v4, v5, arg3);
    }

    // decompiled from Move bytecode v6
}

