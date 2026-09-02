module 0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card_kiosk {
    struct CardRoyaltyRule has drop {
        dummy_field: bool,
    }

    struct CardRoyaltyConfig has drop, store {
        royalty_bps: u64,
        package_version: u64,
    }

    fun assert_royalty_amount(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg2 == (((arg1 as u128) * (arg0 as u128) / (10000 as u128)) as u64), 3);
    }

    public fun confirm_purchase(arg0: &0x2::transfer_policy::TransferPolicy<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>, arg1: 0x2::transfer_policy::TransferRequest<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>) : (0x2::object::ID, u64, 0x2::object::ID) {
        0x2::transfer_policy::confirm_request<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>(arg0, arg1)
    }

    public entry fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_kiosk(arg0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
    }

    public entry fun create_transfer_policy(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new_transfer_policy(arg0, arg1, arg2, arg3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>>(v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun delist_card(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) {
        0x2::kiosk::delist<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>(arg0, arg1, arg2);
    }

    public fun list_card(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64) {
        0x2::kiosk::list<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>(arg0, arg1, arg2, arg3);
    }

    public fun new_kiosk(arg0: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::Kiosk, 0x2::kiosk::KioskOwnerCap) {
        0x2::kiosk::new(arg0)
    }

    fun new_transfer_policy(arg0: &0x2::package::Publisher, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferPolicy<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>, 0x2::transfer_policy::TransferPolicyCap<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>) {
        assert!(arg1 <= 10000, 0);
        assert!(arg2 > 0, 1);
        let (v0, v1) = 0x2::transfer_policy::new<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>(arg0, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = CardRoyaltyRule{dummy_field: false};
        let v5 = CardRoyaltyConfig{
            royalty_bps     : arg1,
            package_version : arg2,
        };
        0x2::transfer_policy::add_rule<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard, CardRoyaltyRule, CardRoyaltyConfig>(v4, &mut v3, &v2, v5);
        (v3, v2)
    }

    public fun pay_royalty(arg0: &mut 0x2::transfer_policy::TransferPolicy<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>, arg1: &0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard, arg2: &mut 0x2::transfer_policy::TransferRequest<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>, arg3: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::object::id<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>(arg1) == 0x2::transfer_policy::item<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>(arg2), 2);
        assert_royalty_amount(royalty_bps(arg0), 0x2::transfer_policy::paid<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>(arg2), 0x2::coin::value<0x2::sui::SUI>(&arg3));
        let v0 = CardRoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_to_balance<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard, CardRoyaltyRule>(v0, arg0, arg3);
        let v1 = CardRoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard, CardRoyaltyRule>(v1, arg2);
    }

    public fun place_card(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard) {
        0x2::kiosk::place<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>(arg0, arg1, arg2);
    }

    public fun place_purchased_card(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard) {
        0x2::kiosk::place<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>(arg0, arg1, arg2);
    }

    public fun policy_package_version(arg0: &0x2::transfer_policy::TransferPolicy<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>) : u64 {
        let v0 = CardRoyaltyRule{dummy_field: false};
        0x2::transfer_policy::get_rule<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard, CardRoyaltyRule, CardRoyaltyConfig>(v0, arg0).package_version
    }

    public fun purchase_card(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>) : (0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard, 0x2::transfer_policy::TransferRequest<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>) {
        0x2::kiosk::purchase<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>(arg0, arg1, arg2)
    }

    public fun royalty_bps(arg0: &0x2::transfer_policy::TransferPolicy<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>) : u64 {
        let v0 = CardRoyaltyRule{dummy_field: false};
        0x2::transfer_policy::get_rule<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard, CardRoyaltyRule, CardRoyaltyConfig>(v0, arg0).royalty_bps
    }

    public fun royalty_due(arg0: &0x2::transfer_policy::TransferPolicy<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>, arg1: u64) : u64 {
        (((arg1 as u128) * (royalty_bps(arg0) as u128) / (10000 as u128)) as u64)
    }

    public fun take_card(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) : 0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard {
        0x2::kiosk::take<0x6596b2b3cad4891e2a21b86ba6f662004228506104a2c3a34e59cade685219d9::trading_card::TradingCard>(arg0, arg1, arg2)
    }

    public fun withdraw_proceeds(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::kiosk::withdraw(arg0, arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

