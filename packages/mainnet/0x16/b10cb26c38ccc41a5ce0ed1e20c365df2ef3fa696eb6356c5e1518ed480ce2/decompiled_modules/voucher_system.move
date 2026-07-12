module 0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::voucher_system {
    struct Voucher has store, key {
        id: 0x2::object::UID,
        customer: address,
        reward_type: 0x1::string::String,
        shop: address,
        points_spent: u64,
        redeemed: bool,
        redeemed_at: u64,
        expiry: u64,
        created_at: u64,
    }

    struct VoucherMinted has copy, drop {
        voucher_id: address,
        customer: address,
        shop: address,
        reward_type: 0x1::string::String,
        points_spent: u64,
        expiry: u64,
        timestamp: u64,
    }

    struct VoucherRedeemed has copy, drop {
        voucher_id: address,
        customer: address,
        shop: address,
        reward_type: 0x1::string::String,
        timestamp: u64,
    }

    public fun get_expiry(arg0: &Voucher) : u64 {
        arg0.expiry
    }

    public fun get_points_spent(arg0: &Voucher) : u64 {
        arg0.points_spent
    }

    public fun get_reward_type(arg0: &Voucher) : 0x1::string::String {
        arg0.reward_type
    }

    public fun get_voucher_customer(arg0: &Voucher) : address {
        arg0.customer
    }

    public fun get_voucher_shop(arg0: &Voucher) : address {
        arg0.shop
    }

    public fun is_expired(arg0: &Voucher, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.expiry
    }

    public fun is_redeemed(arg0: &Voucher) : bool {
        arg0.redeemed
    }

    public(friend) fun migration_mint_voucher(arg0: address, arg1: address, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Voucher{
            id           : 0x2::object::new(arg6),
            customer     : arg0,
            reward_type  : 0x1::string::utf8(arg2),
            shop         : arg1,
            points_spent : arg3,
            redeemed     : false,
            redeemed_at  : 0,
            expiry       : arg4,
            created_at   : arg5,
        };
        0x2::transfer::transfer<Voucher>(v0, arg0);
    }

    public entry fun mint_voucher(arg0: address, arg1: address, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0, 0);
        mint_voucher_internal(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun mint_voucher_internal(arg0: address, arg1: address, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = v0 + 2592000000;
        let v2 = 0x1::string::utf8(arg2);
        let v3 = 0x2::object::new(arg5);
        let v4 = Voucher{
            id           : v3,
            customer     : arg0,
            reward_type  : v2,
            shop         : arg1,
            points_spent : arg3,
            redeemed     : false,
            redeemed_at  : 0,
            expiry       : v1,
            created_at   : v0,
        };
        let v5 = VoucherMinted{
            voucher_id   : 0x2::object::uid_to_address(&v3),
            customer     : arg0,
            shop         : arg1,
            reward_type  : v2,
            points_spent : arg3,
            expiry       : v1,
            timestamp    : v0,
        };
        0x2::event::emit<VoucherMinted>(v5);
        0x2::transfer::transfer<Voucher>(v4, arg0);
    }

    public entry fun redeem_voucher(arg0: &mut Voucher, arg1: &0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::coffee_shop_registry::CoffeeShop, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 == 0x16b10cb26c38ccc41a5ce0ed1e20c365df2ef3fa696eb6356c5e1518ed480ce2::coffee_shop_registry::get_shop_owner(arg1), 0);
        assert!(arg0.shop == v0, 3);
        assert!(!arg0.redeemed, 2);
        assert!(v1 < arg0.expiry, 1);
        arg0.redeemed = true;
        arg0.redeemed_at = v1;
        let v2 = VoucherRedeemed{
            voucher_id  : 0x2::object::uid_to_address(&arg0.id),
            customer    : arg0.customer,
            shop        : arg0.shop,
            reward_type : arg0.reward_type,
            timestamp   : v1,
        };
        0x2::event::emit<VoucherRedeemed>(v2);
    }

    // decompiled from Move bytecode v6
}

