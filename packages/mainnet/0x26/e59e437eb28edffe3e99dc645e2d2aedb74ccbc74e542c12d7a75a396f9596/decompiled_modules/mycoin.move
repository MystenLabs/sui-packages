module 0x26e59e437eb28edffe3e99dc645e2d2aedb74ccbc74e542c12d7a75a396f9596::mycoin {
    struct MYCOIN has drop {
        dummy_field: bool,
    }

    struct Global has store, key {
        id: 0x2::object::UID,
        admin: address,
        fee_rate: u8,
        fee_wallet: address,
        dex_list: 0x2::table::Table<address, bool>,
        supply: 0x2::balance::Supply<MYCOIN>,
    }

    public entry fun add_dex(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        assert!(!0x2::table::contains<address, bool>(&arg0.dex_list, arg1), 101);
        0x2::table::add<address, bool>(&mut arg0.dex_list, arg1, true);
    }

    fun init(arg0: MYCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MYCOIN>(arg0, 2, b"SUINA", b"Suina AI", b"Suina AI token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://chocolate-certain-magpie-708.mypinata.cloud/ipfs/bafkreifdg3he5tdl2lbnstmrze55mznylpwavcck53fhssbp5tejslymam")), arg1);
        let v3 = v1;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYCOIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(0x2::coin::mint<MYCOIN>(&mut v3, 3000000000000000000, arg1), v0);
        let v4 = Global{
            id         : 0x2::object::new(arg1),
            admin      : v0,
            fee_rate   : 10,
            fee_wallet : v0,
            dex_list   : 0x2::table::new<address, bool>(arg1),
            supply     : 0x2::coin::treasury_into_supply<MYCOIN>(v3),
        };
        0x2::transfer::public_share_object<Global>(v4);
    }

    public entry fun remove_dex(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        assert!(0x2::table::contains<address, bool>(&arg0.dex_list, arg1), 101);
        0x2::table::remove<address, bool>(&mut arg0.dex_list, arg1);
    }

    public entry fun transfer_with_fee(arg0: &Global, arg1: address, arg2: address, arg3: u64, arg4: 0x2::coin::Coin<MYCOIN>, arg5: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, bool>(&arg0.dex_list, arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(0x2::coin::split<MYCOIN>(&mut arg4, arg3 * (arg0.fee_rate as u64) / 100, arg5), arg0.fee_wallet);
            0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(arg4, arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<MYCOIN>>(arg4, arg2);
        };
    }

    public entry fun update_fee_rate(arg0: &mut Global, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        arg0.fee_rate = arg1;
    }

    public entry fun update_fee_wallet(arg0: &mut Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 100);
        arg0.fee_wallet = arg1;
    }

    // decompiled from Move bytecode v6
}

