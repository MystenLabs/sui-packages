module 0x1565cf04898af96a19f876d0eaa8f820ea30c4ce304c3c66dda9956244200c26::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct TreasuryBurnedEvent has copy, drop, store {
        owner: address,
        treasury_id: address,
        name: vector<u8>,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<USDC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::mint<USDC>(arg0, arg1, arg3), arg2);
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
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 6, b"USDC", b"USDC", b"Seapad launchpad foundation token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://seapad.s3.ap-southeast-1.amazonaws.com/uploads/PROD/public/media/images/logo_1685439392353.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDC>>(v0, @0xc37ce899eb568f490a521590787b167e65300d15819c85c4a12ee8480f2c3554);
    }

    // decompiled from Move bytecode v6
}

