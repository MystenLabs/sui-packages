module 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::treasury {
    struct TreasuryConfig has key {
        id: 0x2::object::UID,
        treasury_address: address,
        base_mint_price: u64,
        bundle_upgrade_price: u64,
    }

    struct TreasuryAddressUpdated has copy, drop {
        old_address: address,
        new_address: address,
        updated_by: address,
    }

    struct MintPriceUpdated has copy, drop {
        old_price: u64,
        new_price: u64,
        updated_by: address,
    }

    struct BundlePriceUpdated has copy, drop {
        old_price: u64,
        new_price: u64,
        updated_by: address,
    }

    struct PaymentProcessed has copy, drop {
        amount: u64,
        recipient: address,
        payment_type: u8,
    }

    public fun base_mint_price(arg0: &TreasuryConfig) : u64 {
        arg0.base_mint_price
    }

    public fun bundle_upgrade_price(arg0: &TreasuryConfig) : u64 {
        arg0.bundle_upgrade_price
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryConfig{
            id                   : 0x2::object::new(arg0),
            treasury_address     : 0x2::tx_context::sender(arg0),
            base_mint_price      : 20000000000,
            bundle_upgrade_price : 10000000000,
        };
        0x2::transfer::share_object<TreasuryConfig>(v0);
    }

    public(friend) fun process_payment(arg0: &TreasuryConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PaymentProcessed{
            amount       : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            recipient    : arg0.treasury_address,
            payment_type : arg2,
        };
        0x2::event::emit<PaymentProcessed>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury_address);
    }

    public(friend) fun set_base_mint_price(arg0: &mut TreasuryConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 2);
        arg0.base_mint_price = arg1;
        let v0 = MintPriceUpdated{
            old_price  : arg0.base_mint_price,
            new_price  : arg1,
            updated_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<MintPriceUpdated>(v0);
    }

    public(friend) fun set_bundle_upgrade_price(arg0: &mut TreasuryConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 2);
        arg0.bundle_upgrade_price = arg1;
        let v0 = BundlePriceUpdated{
            old_price  : arg0.bundle_upgrade_price,
            new_price  : arg1,
            updated_by : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<BundlePriceUpdated>(v0);
    }

    public(friend) fun set_treasury_address(arg0: &mut TreasuryConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 1);
        arg0.treasury_address = arg1;
        let v0 = TreasuryAddressUpdated{
            old_address : arg0.treasury_address,
            new_address : arg1,
            updated_by  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<TreasuryAddressUpdated>(v0);
    }

    public fun total_bundle_price(arg0: &TreasuryConfig) : u64 {
        arg0.base_mint_price + arg0.bundle_upgrade_price
    }

    public fun treasury_address(arg0: &TreasuryConfig) : address {
        arg0.treasury_address
    }

    // decompiled from Move bytecode v7
}

