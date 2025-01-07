module 0x44a63e7849d66d839a4f1f4d12281a4662e9cb98edb9b6a4200e944f5a536464::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct TreasuryBurnedEvent has copy, drop, store {
        owner: address,
        treasury_id: address,
        name: vector<u8>,
    }

    public entry fun burn_cap(arg0: 0x2::coin::TreasuryCap<USDC>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryBurnedEvent{
            owner       : 0x2::tx_context::sender(arg1),
            treasury_id : 0x2::object::id_address<0x2::coin::TreasuryCap<USDC>>(&arg0),
            name        : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<USDC>())),
        };
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<USDC>>(arg0);
        0x2::event::emit<TreasuryBurnedEvent>(v0);
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 6, b"USDC", b"USDC", b"xxxxxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"xxxxxxx"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v0, @0xc37ce899eb568f490a521590787b167e65300d15819c85c4a12ee8480f2c3554);
    }

    public entry fun minto(arg0: &mut 0x2::coin::TreasuryCap<USDC>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<USDC>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}

