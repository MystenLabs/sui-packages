module 0xa00d80dfff49e2212a45a54c71538b4b494834cc0417ce252cd5e6c96a7dd1f1::payment {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        treasury: address,
    }

    struct BlockBoltPayment has copy, drop {
        payment_id: vector<u8>,
        payer: address,
        merchant: address,
        total_amount: u64,
        merchant_amount: u64,
        fee_amount: u64,
        fee_bps: u64,
    }

    public fun get_fee_bps(arg0: &Config) : u64 {
        arg0.fee_bps
    }

    public fun get_treasury(arg0: &Config) : address {
        arg0.treasury
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id       : 0x2::object::new(arg0),
            fee_bps  : 10,
            treasury : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public entry fun pay<T0>(arg0: &Config, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = v0 * arg0.fee_bps / 10000;
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v1, arg4), arg0.treasury);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg3);
        let v2 = BlockBoltPayment{
            payment_id      : arg2,
            payer           : 0x2::tx_context::sender(arg4),
            merchant        : arg3,
            total_amount    : v0,
            merchant_amount : v0 - v1,
            fee_amount      : v1,
            fee_bps         : arg0.fee_bps,
        };
        0x2::event::emit<BlockBoltPayment>(v2);
    }

    public entry fun update_fee(arg0: &AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 10000, 1);
        arg1.fee_bps = arg2;
    }

    public entry fun update_treasury(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.treasury = arg2;
    }

    // decompiled from Move bytecode v6
}

