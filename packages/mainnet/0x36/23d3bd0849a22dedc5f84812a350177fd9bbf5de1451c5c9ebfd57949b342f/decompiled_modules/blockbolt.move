module 0x3623d3bd0849a22dedc5f84812a350177fd9bbf5de1451c5c9ebfd57949b342f::blockbolt {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct Treasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct FeeSettings has key {
        id: 0x2::object::UID,
        fee_percentage: u64,
    }

    struct CoinInfo has copy, drop, store {
        decimals: u8,
    }

    struct CoinInfoTable has store, key {
        id: 0x2::object::UID,
        coin_info: 0x2::table::Table<0x1::type_name::TypeName, CoinInfo>,
    }

    struct MerchantDetails has store, key {
        id: 0x2::object::UID,
        amount: u64,
        merchant_id: u64,
        protocol_name: 0x1::string::String,
        merchant_name: 0x1::string::String,
    }

    struct MerchantDetailsEvent has copy, drop {
        amount: u64,
        merchant_id: u64,
        protocol_name: 0x1::string::String,
        merchant_name: 0x1::string::String,
    }

    public entry fun add_coin<T0>(arg0: &OwnerCap, arg1: &mut CoinInfoTable, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg1.coin_info, v0), 2);
        let v1 = CoinInfo{decimals: arg2};
        0x2::table::add<0x1::type_name::TypeName, CoinInfo>(&mut arg1.coin_info, v0, v1);
    }

    public fun check<T0>(arg0: &CoinInfoTable) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg0.coin_info, v0), 4);
        0x2::math::pow(10, (0x2::table::borrow<0x1::type_name::TypeName, CoinInfo>(&arg0.coin_info, v0).decimals as u8))
    }

    public entry fun collect_treasury<T0>(arg0: &OwnerCap, arg1: &mut Treasury<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun delete_coin<T0>(arg0: &OwnerCap, arg1: &mut CoinInfoTable, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg1.coin_info, v0), 3);
        0x2::table::remove<0x1::type_name::TypeName, CoinInfo>(&mut arg1.coin_info, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        let v1 = CoinInfoTable{
            id        : 0x2::object::new(arg0),
            coin_info : 0x2::table::new<0x1::type_name::TypeName, CoinInfo>(arg0),
        };
        let v2 = CoinInfo{decimals: 9};
        0x2::table::add<0x1::type_name::TypeName, CoinInfo>(&mut v1.coin_info, 0x1::type_name::get<0x2::sui::SUI>(), v2);
        0x2::transfer::share_object<CoinInfoTable>(v1);
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize_fee(arg0: &OwnerCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= 10000, 5);
        let v0 = FeeSettings{
            id             : 0x2::object::new(arg2),
            fee_percentage : arg1,
        };
        0x2::transfer::share_object<FeeSettings>(v0);
    }

    public fun initializer<T0>(arg0: &OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
    }

    public fun send<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut Treasury<T0>, arg2: &CoinInfoTable, arg3: &FeeSettings, arg4: 0x1::string::String, arg5: address, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg6, 9223372595200524289);
        let v0 = 0x1::string::utf8(b"Powered By BlockBolt");
        assert!(0x2::table::contains<0x1::type_name::TypeName, CoinInfo>(&arg2.coin_info, 0x1::type_name::get<T0>()), 4);
        let v1 = (((arg6 as u128) * (arg3.fee_percentage as u128) / (10000 as u128)) as u64);
        assert!(v1 <= arg6, 6);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg0, v1, arg8)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg5);
        let v2 = MerchantDetails{
            id            : 0x2::object::new(arg8),
            amount        : arg6,
            merchant_id   : arg7,
            protocol_name : v0,
            merchant_name : arg4,
        };
        let v3 = MerchantDetailsEvent{
            amount        : arg6,
            merchant_id   : arg7,
            protocol_name : v0,
            merchant_name : arg4,
        };
        0x2::event::emit<MerchantDetailsEvent>(v3);
        0x2::transfer::transfer<MerchantDetails>(v2, 0x2::tx_context::sender(arg8));
    }

    public entry fun update_fee(arg0: &OwnerCap, arg1: &mut FeeSettings, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 10000, 5);
        arg1.fee_percentage = arg2;
    }

    // decompiled from Move bytecode v6
}

