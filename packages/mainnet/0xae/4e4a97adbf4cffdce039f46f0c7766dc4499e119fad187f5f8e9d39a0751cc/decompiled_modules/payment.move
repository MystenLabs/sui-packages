module 0xae4e4a97adbf4cffdce039f46f0c7766dc4499e119fad187f5f8e9d39a0751cc::payment {
    struct Global has key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
        beneficiary: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DepositSHTEvent has copy, drop {
        user: address,
        sht_amount: u64,
    }

    struct DepositSUIEvent has copy, drop {
        user: address,
        sui_amount: u64,
    }

    public entry fun change_beneficiary_address(arg0: &AdminCap, arg1: &mut Global, arg2: address) {
        arg1.beneficiary = arg2;
    }

    public entry fun deposit_sht(arg0: &mut Global, arg1: 0x2::coin::Coin<0x36a84eb78e931d5a00879c7670ec61e4bb42d41c98cc6486c8a05a3b4ca7d752::sht::SHT>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        let v0 = 0x2::coin::value<0x36a84eb78e931d5a00879c7670ec61e4bb42d41c98cc6486c8a05a3b4ca7d752::sht::SHT>(&arg1);
        assert!(v0 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x36a84eb78e931d5a00879c7670ec61e4bb42d41c98cc6486c8a05a3b4ca7d752::sht::SHT>>(arg1, arg0.beneficiary);
        let v1 = DepositSHTEvent{
            user       : 0x2::tx_context::sender(arg2),
            sht_amount : v0,
        };
        0x2::event::emit<DepositSHTEvent>(v1);
    }

    public entry fun deposit_sui(arg0: &mut Global, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.beneficiary);
        let v1 = DepositSUIEvent{
            user       : 0x2::tx_context::sender(arg2),
            sui_amount : v0,
        };
        0x2::event::emit<DepositSUIEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = Global{
            id          : 0x2::object::new(arg0),
            version     : 1,
            admin       : 0x2::object::id<AdminCap>(&v0),
            beneficiary : @0x44843cfc10bc14d9b0aed983bf8a60d92f7fb4bcf1a5c4c283c11be46029edee,
        };
        0x2::transfer::share_object<Global>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

