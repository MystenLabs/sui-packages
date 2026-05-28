module 0xb0fdf5fd39c121a129c85be416cc4e610a5a064350263679fec1ce0c5ebf4e6a::factory {
    struct FactoryConfig has key {
        id: 0x2::object::UID,
        fee_mist: u64,
        fee_recipient: address,
    }

    struct CreationReceipt has store, key {
        id: 0x2::object::UID,
        creator: address,
        paid_mist: u64,
        fee_recipient: address,
    }

    struct FactoryConfigCreated has copy, drop {
        fee_mist: u64,
        fee_recipient: address,
    }

    struct FeePaid has copy, drop {
        creator: address,
        paid_mist: u64,
        fee_recipient: address,
    }

    public entry fun create_config(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 2);
        let v0 = FactoryConfig{
            id            : 0x2::object::new(arg2),
            fee_mist      : arg0,
            fee_recipient : arg1,
        };
        0x2::transfer::share_object<FactoryConfig>(v0);
        let v1 = FactoryConfigCreated{
            fee_mist      : arg0,
            fee_recipient : arg1,
        };
        0x2::event::emit<FactoryConfigCreated>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun pay_creation_fee(arg0: &FactoryConfig, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = arg0.fee_mist;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v1, arg2), arg0.fee_recipient);
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        };
        let v2 = CreationReceipt{
            id            : 0x2::object::new(arg2),
            creator       : v0,
            paid_mist     : v1,
            fee_recipient : arg0.fee_recipient,
        };
        0x2::transfer::transfer<CreationReceipt>(v2, v0);
        let v3 = FeePaid{
            creator       : v0,
            paid_mist     : v1,
            fee_recipient : arg0.fee_recipient,
        };
        0x2::event::emit<FeePaid>(v3);
    }

    public entry fun set_fee_mist(arg0: &mut FactoryConfig, arg1: u64) {
        arg0.fee_mist = arg1;
    }

    public entry fun set_fee_recipient(arg0: &mut FactoryConfig, arg1: address) {
        assert!(arg1 != @0x0, 2);
        arg0.fee_recipient = arg1;
    }

    // decompiled from Move bytecode v7
}

