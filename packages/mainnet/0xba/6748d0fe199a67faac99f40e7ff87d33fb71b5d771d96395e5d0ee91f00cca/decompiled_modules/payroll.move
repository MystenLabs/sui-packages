module 0xba6748d0fe199a67faac99f40e7ff87d33fb71b5d771d96395e5d0ee91f00cca::payroll {
    struct Registry has key {
        id: 0x2::object::UID,
        metadata: 0x2::coin::CoinMetadata<PAYROLL>,
    }

    struct PAYROLL has drop {
        dummy_field: bool,
    }

    struct Payroll has store {
        start_date: u64,
        final_date: u64,
        original_balance: u64,
        balance: 0x2::balance::Balance<PAYROLL>,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PAYROLL>, arg1: 0x2::coin::Coin<PAYROLL>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::balance::value<PAYROLL>(0x2::coin::balance<PAYROLL>(&arg1)) >= arg2, 0);
        0x2::coin::burn<PAYROLL>(arg0, arg1)
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<PAYROLL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 * 30 / 100;
        0x2::coin::mint_and_transfer<PAYROLL>(arg0, v0, 0x2::tx_context::sender(arg3), arg3);
        0x2::coin::mint_and_transfer<PAYROLL>(arg0, arg1 - v0, arg2, arg3);
    }

    fun init(arg0: PAYROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAYROLL>(arg0, 9, b"PAY", b"PAYROLL", b"PayRoll Coin is the right protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafybeiecppfzpgx7xosf7h4a2zistip2d4lawqkwsp2dtp3ucmjpmnb6tq.ipfs.nftstorage.link/"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAYROLL>>(v1);
        0x2::coin::mint_and_transfer<PAYROLL>(&mut v2, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAYROLL>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_and_transfer_with_tax(arg0: &mut 0x2::coin::TreasuryCap<PAYROLL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1 * 30 / 100;
        0x2::coin::mint_and_transfer<PAYROLL>(arg0, v0, 0x2::tx_context::sender(arg3), arg3);
        0x2::coin::mint_and_transfer<PAYROLL>(arg0, arg1 - v0, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

