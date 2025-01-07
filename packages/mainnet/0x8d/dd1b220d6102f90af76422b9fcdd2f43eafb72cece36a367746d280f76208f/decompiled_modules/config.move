module 0x72b79165ebc2a35e9166168b952c31aafc1531b73bc29c471dc4944b0054b88e::config {
    struct ProtocolAdmin has store, key {
        id: 0x2::object::UID,
    }

    struct FeeConfig has store, key {
        id: 0x2::object::UID,
        lending_fee_bps: u64,
        swap_fee_bps: u64,
        amm_fee_bps: u64,
        clmm_fee_bps: u64,
        fee_recipient: address,
    }

    public fun amm_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.amm_fee_bps
    }

    public fun change_amm_fee_bps(arg0: &ProtocolAdmin, arg1: &mut FeeConfig, arg2: u64) {
        arg1.amm_fee_bps = arg2;
    }

    public fun change_clmm_fee_bps(arg0: &ProtocolAdmin, arg1: &mut FeeConfig, arg2: u64) {
        arg1.clmm_fee_bps = arg2;
    }

    public fun change_fee(arg0: &ProtocolAdmin, arg1: &mut FeeConfig, arg2: u64) {
        abort 0
    }

    public fun change_fee_recipient(arg0: &ProtocolAdmin, arg1: &mut FeeConfig, arg2: address) {
        arg1.fee_recipient = arg2;
    }

    public fun change_lending_fee_bps(arg0: &ProtocolAdmin, arg1: &mut FeeConfig, arg2: u64) {
        arg1.lending_fee_bps = arg2;
    }

    public fun change_swap_fee_bps(arg0: &ProtocolAdmin, arg1: &mut FeeConfig, arg2: u64) {
        arg1.swap_fee_bps = arg2;
    }

    public fun clmm_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.clmm_fee_bps
    }

    public fun fee_recipient(arg0: &FeeConfig) : address {
        arg0.fee_recipient
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolAdmin{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<ProtocolAdmin>(v0, 0x2::tx_context::sender(arg0));
        let v1 = FeeConfig{
            id              : 0x2::object::new(arg0),
            lending_fee_bps : 30,
            swap_fee_bps    : 30,
            amm_fee_bps     : 30,
            clmm_fee_bps    : 30,
            fee_recipient   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_share_object<FeeConfig>(v1);
    }

    public fun lending_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.lending_fee_bps
    }

    public fun swap_fee_bps(arg0: &FeeConfig) : u64 {
        arg0.swap_fee_bps
    }

    // decompiled from Move bytecode v6
}

