module 0x4bbb8e16bdd18515c9cf9974e53cd8261360041ed24aa35d0feeef9a58178e5b::token {
    struct Registry has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<TOKEN>,
    }

    struct TOKEN has drop {
        dummy_field: bool,
    }

    struct Token has store {
        start_date: u64,
        final_date: u64,
        original_balance: u64,
        balance: 0x2::balance::Balance<TOKEN>,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: 0x2::coin::Coin<TOKEN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::balance::value<TOKEN>(0x2::coin::balance<TOKEN>(&arg1)) >= arg2, 0);
        0x2::coin::burn<TOKEN>(arg0, arg1)
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"TEST", b"Test Token", b"Token for test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://upload.wikimedia.org/wikipedia/en/6/63/Feels_good_man.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::coin::mint_and_transfer<TOKEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

