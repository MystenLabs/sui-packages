module 0xccadacec9d8ff778bd83735a769bbb8f38fc4c4e1818e0ece00985afab995ea1::ContractToken {
    struct DecotToken has drop {
        dummy_field: bool,
    }

    struct MinterCap has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<DecotToken>,
    }

    public entry fun burn(arg0: &mut MinterCap, arg1: 0x2::coin::Coin<DecotToken>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<DecotToken>(&mut arg0.treasury_cap, arg1);
    }

    public entry fun mint(arg0: &mut MinterCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DecotToken>>(0x2::coin::mint<DecotToken>(&mut arg0.treasury_cap, arg1, arg3), arg2);
    }

    public fun initializer(arg0: DecotToken, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DecotToken>(arg0, 18, b"DECOT", b"Decot", b"Decot Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DecotToken>>(v1);
        let v2 = MinterCap{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::transfer<MinterCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun transfer_tokens(arg0: 0x2::coin::Coin<DecotToken>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DecotToken>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

