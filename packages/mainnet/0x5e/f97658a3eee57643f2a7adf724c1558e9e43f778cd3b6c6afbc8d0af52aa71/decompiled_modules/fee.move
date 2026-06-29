module 0x5ef97658a3eee57643f2a7adf724c1558e9e43f778cd3b6c6afbc8d0af52aa71::fee {
    struct FEE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeConfig has key {
        id: 0x2::object::UID,
        fee_wallet: address,
        fee_bps: u64,
    }

    struct FeeCollected has copy, drop {
        payer: address,
        coin_type: 0x1::type_name::TypeName,
        amount_in: u64,
        fee_amount: u64,
        fee_wallet: address,
    }

    public fun fee_bps(arg0: &FeeConfig) : u64 {
        arg0.fee_bps
    }

    public fun fee_wallet(arg0: &FeeConfig) : address {
        arg0.fee_wallet
    }

    fun init(arg0: FEE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<FEE>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"SuiSwap"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(x"41646d696e206361706162696c69747920666f7220746865205375695377617020666565206d6f64756c6520e2809420636f6e74726f6c732074686520636f6d6d697373696f6e207261746520616e64206665652077616c6c65742e"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://swap.epinio.playunknown.com/icon.png"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://swap.epinio.playunknown.com"));
        let v6 = 0x2::display::new_with_fields<AdminCap>(&v1, v2, v4, arg1);
        0x2::display::update_version<AdminCap>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<AdminCap>>(v6, v0);
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v7, v0);
        let v8 = FeeConfig{
            id         : 0x2::object::new(arg1),
            fee_wallet : v0,
            fee_bps    : 30,
        };
        0x2::transfer::share_object<FeeConfig>(v8);
    }

    public fun max_bps() : u64 {
        1000
    }

    public fun set_fee_bps(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: u64) {
        assert!(arg2 <= 1000, 0);
        arg1.fee_bps = arg2;
    }

    public fun set_fee_wallet(arg0: &AdminCap, arg1: &mut FeeConfig, arg2: address) {
        arg1.fee_wallet = arg2;
    }

    public fun take_fee<T0>(arg0: &FeeConfig, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = (((v0 as u128) * (arg0.fee_bps as u128) / (10000 as u128)) as u64);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v1, arg2), arg0.fee_wallet);
        };
        let v2 = FeeCollected{
            payer      : 0x2::tx_context::sender(arg2),
            coin_type  : 0x1::type_name::with_defining_ids<T0>(),
            amount_in  : v0,
            fee_amount : v1,
            fee_wallet : arg0.fee_wallet,
        };
        0x2::event::emit<FeeCollected>(v2);
        arg1
    }

    // decompiled from Move bytecode v7
}

