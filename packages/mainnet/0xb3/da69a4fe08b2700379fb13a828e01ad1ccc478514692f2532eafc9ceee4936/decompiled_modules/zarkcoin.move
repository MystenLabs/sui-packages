module 0xb3da69a4fe08b2700379fb13a828e01ad1ccc478514692f2532eafc9ceee4936::zarkcoin {
    struct ZARKCOIN has drop {
        dummy_field: bool,
    }

    struct MintManager has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<ZARKCOIN>,
        usdc_treasury: address,
        authority: address,
    }

    fun i64_to_u64(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::I64) : u64 {
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(arg0), 33);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(arg0)
    }

    fun init(arg0: ZARKCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZARKCOIN>(arg0, 9, b"WAGMI", b"WAGMI COIN", b"Powering the new economy with we all gonna make it.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZARKCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZARKCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_new_coins_authority(arg0: &mut MintManager, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.authority, 77);
        0x2::transfer::public_transfer<0x2::coin::Coin<ZARKCOIN>>(0x2::coin::mint<ZARKCOIN>(&mut arg0.treasury_cap, arg1, arg3), arg2);
    }

    public fun mint_one_to_one_usdc(arg0: &mut MintManager, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ZARKCOIN> {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg3, arg2, 60);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg3);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        assert!(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2) != x"eaa020c61cc479712813461ce153894a96a6c00b21ed0cfc2798d1f9a9e9c94a", 1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1, arg0.usdc_treasury);
        0x2::coin::mint<ZARKCOIN>(&mut arg0.treasury_cap, 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1) * i64_to_u64(&v4) * 0x1::u64::pow(10, 9) / 0x1::u64::pow(10, (i64_to_u64(&v3) as u8)) * 0x1::u64::pow(10, 6), arg4)
    }

    public fun set_up_after_init(arg0: 0x2::coin::TreasuryCap<ZARKCOIN>, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MintManager{
            id            : 0x2::object::new(arg3),
            treasury_cap  : arg0,
            usdc_treasury : arg1,
            authority     : arg2,
        };
        0x2::transfer::public_share_object<MintManager>(v0);
    }

    // decompiled from Move bytecode v6
}

