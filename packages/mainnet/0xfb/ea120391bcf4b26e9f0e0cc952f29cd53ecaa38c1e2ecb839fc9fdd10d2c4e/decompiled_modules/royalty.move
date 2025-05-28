module 0xfbea120391bcf4b26e9f0e0cc952f29cd53ecaa38c1e2ecb839fc9fdd10d2c4e::royalty {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        amount_bp: u64,
        admin: address,
    }

    public fun pay<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<0xfbea120391bcf4b26e9f0e0cc952f29cd53ecaa38c1e2ecb839fc9fdd10d2c4e::storage::TestNfts>, arg1: &mut 0x2::transfer_policy::TransferRequest<0xfbea120391bcf4b26e9f0e0cc952f29cd53ecaa38c1e2ecb839fc9fdd10d2c4e::storage::TestNfts>, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Rule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<0xfbea120391bcf4b26e9f0e0cc952f29cd53ecaa38c1e2ecb839fc9fdd10d2c4e::storage::TestNfts, Rule, Config>(v0, arg0);
        let v2 = (((0x2::transfer_policy::paid<0xfbea120391bcf4b26e9f0e0cc952f29cd53ecaa38c1e2ecb839fc9fdd10d2c4e::storage::TestNfts>(arg1) as u128) * (v1.amount_bp as u128) / 10000) as u64);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v2, arg3), v1.admin);
        let v3 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<0xfbea120391bcf4b26e9f0e0cc952f29cd53ecaa38c1e2ecb839fc9fdd10d2c4e::storage::TestNfts, Rule>(v3, arg1);
    }

    public(friend) fun setup(arg0: &mut 0x2::transfer_policy::TransferPolicy<0xfbea120391bcf4b26e9f0e0cc952f29cd53ecaa38c1e2ecb839fc9fdd10d2c4e::storage::TestNfts>, arg1: &0x2::transfer_policy::TransferPolicyCap<0xfbea120391bcf4b26e9f0e0cc952f29cd53ecaa38c1e2ecb839fc9fdd10d2c4e::storage::TestNfts>, arg2: address) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            amount_bp : 500,
            admin     : arg2,
        };
        0x2::transfer_policy::add_rule<0xfbea120391bcf4b26e9f0e0cc952f29cd53ecaa38c1e2ecb839fc9fdd10d2c4e::storage::TestNfts, Rule, Config>(v0, arg0, arg1, v1);
    }

    // decompiled from Move bytecode v6
}

