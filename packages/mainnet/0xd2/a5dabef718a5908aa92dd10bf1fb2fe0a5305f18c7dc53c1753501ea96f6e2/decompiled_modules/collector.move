module 0xd2a5dabef718a5908aa92dd10bf1fb2fe0a5305f18c7dc53c1753501ea96f6e2::collector {
    struct COLLECTOR has drop {
        dummy_field: bool,
    }

    struct Collector has store, key {
        id: 0x2::object::UID,
        receiver: address,
        bonding_curve_threshold: u64,
        bonding_curve_fee: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        col_id: 0x2::object::ID,
    }

    fun check_admin(arg0: &Collector, arg1: &AdminCap) {
        assert!(0x2::object::borrow_id<Collector>(arg0) == &arg1.col_id, 0);
    }

    public fun getBondingCurveFee(arg0: &mut Collector) : u64 {
        arg0.bonding_curve_fee
    }

    public fun getBondingCurveThreshold(arg0: &mut Collector) : u64 {
        arg0.bonding_curve_threshold
    }

    fun init(arg0: COLLECTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = Collector{
            id                      : v0,
            receiver                : 0x2::tx_context::sender(arg1),
            bonding_curve_threshold : 6900000000000,
            bonding_curve_fee       : 200000000000,
        };
        let v2 = AdminCap{
            id     : 0x2::object::new(arg1),
            col_id : 0x2::object::uid_to_inner(&v0),
        };
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<Collector>(v1);
    }

    public fun sendFee(arg0: &Collector, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.receiver);
    }

    public fun setBondingCurveFee(arg0: &AdminCap, arg1: &mut Collector, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_admin(arg1, arg0);
        arg1.bonding_curve_fee = arg2;
    }

    public fun setBondingCurveThreshold(arg0: &AdminCap, arg1: &mut Collector, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_admin(arg1, arg0);
        arg1.bonding_curve_threshold = arg2;
    }

    public fun setCollector(arg0: &AdminCap, arg1: &mut Collector, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        check_admin(arg1, arg0);
        arg1.receiver = arg2;
    }

    // decompiled from Move bytecode v6
}

