module 0x24c62c1c331a3244ab07e5160d49a0d8300c4db9f42c52dc40b039fb7a19de84::treasury {
    struct TreasuryConfig has key {
        id: 0x2::object::UID,
        beneficiary: address,
    }

    struct TreasuryCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeCollected has copy, drop {
        amount: u64,
        payer: address,
    }

    public fun deposit_fee<T0>(arg0: &TreasuryConfig, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeCollected{
            amount : 0x2::coin::value<T0>(&arg1),
            payer  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<FeeCollected>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.beneficiary);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = TreasuryConfig{
            id          : 0x2::object::new(arg0),
            beneficiary : v0,
        };
        0x2::transfer::share_object<TreasuryConfig>(v1);
        let v2 = TreasuryCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<TreasuryCap>(v2, v0);
    }

    public fun update_beneficiary(arg0: &TreasuryCap, arg1: &mut TreasuryConfig, arg2: address) {
        arg1.beneficiary = arg2;
    }

    // decompiled from Move bytecode v6
}

