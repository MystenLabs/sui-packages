module 0x3c1a2f2d7bd19397c105b2acdd91ae0215be73a7a0b7e298c345c3cabd2f31ba::sui_token {
    struct SUI_TOKEN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintEvent has copy, drop {
        amount: u64,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUI_TOKEN>, arg1: 0x2::coin::Coin<SUI_TOKEN>) {
        0x2::coin::burn<SUI_TOKEN>(arg0, arg1);
    }

    public fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<SUI_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUI_TOKEN>(arg0, arg1, arg2, arg3);
        let v0 = MintEvent{amount: arg1};
        0x2::event::emit<MintEvent>(v0);
    }

    fun init(arg0: SUI_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let (v1, v2) = 0x2::coin::create_currency<SUI_TOKEN>(arg0, 6, b"MTK", b"MyToken", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_TOKEN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

