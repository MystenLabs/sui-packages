module 0xeb31f6bcb8c4cb4d9288354df02f95ec5567b79967b22675cd6c8adefec1cd25::sasuike {
    struct SASUIKE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SASUIKE>, arg1: 0x2::coin::Coin<SASUIKE>) {
        0x2::coin::burn<SASUIKE>(arg0, arg1);
    }

    public entry fun transfer(arg0: &mut 0x2::coin::Coin<SASUIKE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SASUIKE>>(0x2::coin::split<SASUIKE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SASUIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASUIKE>(arg0, 9, b"SASUIKE", b"Sasuke feels bad today", b"Sasuke feels bad today", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://blush-elderly-mink-482.mypinata.cloud/ipfs/QmSTViBm9RUmiTqSYkVvjFqhTkYVJDjddWznY5CdGRonnK")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SASUIKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASUIKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SASUIKE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SASUIKE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

