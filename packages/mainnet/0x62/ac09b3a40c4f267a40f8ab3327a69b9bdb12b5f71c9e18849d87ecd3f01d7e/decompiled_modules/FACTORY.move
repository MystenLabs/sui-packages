module 0x62ac09b3a40c4f267a40f8ab3327a69b9bdb12b5f71c9e18849d87ecd3f01d7e::FACTORY {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    struct FACTORY has drop {
        dummy_field: bool,
    }

    struct CONFIG has key {
        id: 0x2::object::UID,
        fee_amount: u64,
        fee_receiver: address,
    }

    struct ADMIN has key {
        id: 0x2::object::UID,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: 0x2::coin::Coin<TOKEN>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<TOKEN>(0x2::coin::balance<TOKEN>(&arg1)) >= arg2, 2);
        0x2::coin::burn<TOKEN>(arg0, arg1);
    }

    public fun admin_deploy_token(arg0: &ADMIN, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u8, arg5: 0x1::option::Option<0x2::url::Url>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<TOKEN> {
        assert!(0x1::vector::length<u8>(&arg2) <= 10, 0);
        assert!(arg4 > 1 && arg4 <= 9, 1);
        let v0 = TOKEN{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<TOKEN>(v0, arg4, arg2, arg1, arg3, arg5, arg7);
        let v3 = v1;
        0x2::coin::mint_and_transfer<TOKEN>(&mut v3, arg6, 0x2::tx_context::sender(arg7), arg7);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v2);
        v3
    }

    public fun deploy_token(arg0: &CONFIG, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: 0x1::option::Option<0x2::url::Url>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<TOKEN> {
        assert!(0x1::vector::length<u8>(&arg3) <= 10, 0);
        assert!(arg5 > 1 && arg5 <= 9, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, arg0.fee_amount, arg8), arg0.fee_receiver);
        let v0 = TOKEN{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<TOKEN>(v0, arg5, arg3, arg2, arg4, arg6, arg8);
        let v3 = v1;
        0x2::coin::mint_and_transfer<TOKEN>(&mut v3, arg7, 0x2::tx_context::sender(arg8), arg8);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v2);
        v3
    }

    public fun deploy_token_and_renounce_ownership(arg0: &CONFIG, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u8, arg6: 0x1::option::Option<0x2::url::Url>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg3) <= 10, 0);
        assert!(arg5 > 1 && arg5 <= 8, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg1, arg0.fee_amount, arg8), arg0.fee_receiver);
        let v0 = TOKEN{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<TOKEN>(v0, arg5, arg3, arg2, arg4, arg6, arg8);
        let v3 = v1;
        0x2::coin::mint_and_transfer<TOKEN>(&mut v3, arg7, 0x2::tx_context::sender(arg8), arg8);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TOKEN>>(v3);
    }

    fun init(arg0: FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CONFIG{
            id           : 0x2::object::new(arg1),
            fee_amount   : 20000000000,
            fee_receiver : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<CONFIG>(v0);
        let v1 = ADMIN{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<ADMIN>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOKEN>(arg0, arg1, arg2, arg3);
    }

    public entry fun update_fee(arg0: &ADMIN, arg1: &mut CONFIG, arg2: u64) {
        arg1.fee_amount = arg2;
    }

    public entry fun update_fee_receiver(arg0: &ADMIN, arg1: &mut CONFIG, arg2: address) {
        arg1.fee_receiver = arg2;
    }

    // decompiled from Move bytecode v6
}

