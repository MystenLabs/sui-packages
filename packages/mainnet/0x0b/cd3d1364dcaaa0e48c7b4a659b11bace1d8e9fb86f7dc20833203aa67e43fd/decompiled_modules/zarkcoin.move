module 0xbcd3d1364dcaaa0e48c7b4a659b11bace1d8e9fb86f7dc20833203aa67e43fd::zarkcoin {
    struct ZARKCOIN has drop {
        dummy_field: bool,
    }

    struct MintManager has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<ZARKCOIN>,
        usdc_treasury: address,
        authority: address,
    }

    fun init(arg0: ZARKCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZARKCOIN>(arg0, 9, b"ZARK", b"ZARKCOIN", b"Powering the new economy.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZARKCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZARKCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_new_coins_authority(arg0: &mut MintManager, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.authority, 77);
        0x2::transfer::public_transfer<0x2::coin::Coin<ZARKCOIN>>(0x2::coin::mint<ZARKCOIN>(&mut arg0.treasury_cap, arg1, arg3), arg2);
    }

    public fun mint_one_to_one_usdc(arg0: &mut MintManager, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<ZARKCOIN> {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1, arg0.usdc_treasury);
        0x2::coin::mint<ZARKCOIN>(&mut arg0.treasury_cap, 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1), arg2)
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

