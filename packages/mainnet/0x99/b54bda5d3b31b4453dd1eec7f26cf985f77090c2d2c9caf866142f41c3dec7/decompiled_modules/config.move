module 0x99b54bda5d3b31b4453dd1eec7f26cf985f77090c2d2c9caf866142f41c3dec7::config {
    struct Gateway has key {
        id: 0x2::object::UID,
        supported_coins: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        protocol_fee_bps: u64,
        max_bps: u64,
        treasury: address,
        paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AggregatorCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_supported_coin<T0>(arg0: &AdminCap, arg1: &mut Gateway) {
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.supported_coins, 0x1::type_name::with_defining_ids<T0>());
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Gateway{
            id               : 0x2::object::new(arg0),
            supported_coins  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            protocol_fee_bps : 0,
            max_bps          : 10000,
            treasury         : 0x2::tx_context::sender(arg0),
            paused           : false,
        };
        0x2::transfer::share_object<Gateway>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_coin_supported<T0>(arg0: &Gateway) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.supported_coins, &v0)
    }

    public fun is_paused(arg0: &Gateway) : bool {
        arg0.paused
    }

    public fun max_bps(arg0: &Gateway) : u64 {
        arg0.max_bps
    }

    public fun mint_aggregator_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AggregatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AggregatorCap>(v0, arg1);
    }

    public fun pause(arg0: &AdminCap, arg1: &mut Gateway) {
        arg1.paused = true;
    }

    public fun protocol_fee_bps(arg0: &Gateway) : u64 {
        arg0.protocol_fee_bps
    }

    public fun remove_supported_coin<T0>(arg0: &AdminCap, arg1: &mut Gateway) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.supported_coins, &v0);
    }

    public fun set_max_bps(arg0: &AdminCap, arg1: &mut Gateway, arg2: u64) {
        assert!(arg2 <= 10000, 100);
        arg1.max_bps = arg2;
    }

    public fun set_protocol_fee(arg0: &AdminCap, arg1: &mut Gateway, arg2: u64) {
        assert!(arg2 <= 10000, 100);
        arg1.protocol_fee_bps = arg2;
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut Gateway, arg2: address) {
        arg1.treasury = arg2;
    }

    public fun treasury(arg0: &Gateway) : address {
        arg0.treasury
    }

    public fun unpause(arg0: &AdminCap, arg1: &mut Gateway) {
        arg1.paused = false;
    }

    // decompiled from Move bytecode v7
}

