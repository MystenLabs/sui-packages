module 0xaaf31cee7b44907a0484b044a87a77a168da5701b1c6611ba85fca5633ff5010::voucher {
    struct VOUCHER has drop {
        dummy_field: bool,
    }

    struct VoucherAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Voucher<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: u64,
        expiration_in_ms: u64,
        image_url: 0x1::string::String,
        tier: u8,
        is_used: bool,
    }

    public fun balance<T0>(arg0: &Voucher<T0>) : u64 {
        arg0.balance
    }

    fun get_voucher_admin_cap(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VoucherAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<VoucherAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_voucher<T0>(arg0: &mut VoucherAdminCap, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::clock::Clock, arg4: u64, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) : Voucher<T0> {
        Voucher<T0>{
            id               : 0x2::object::new(arg6),
            balance          : arg2,
            expiration_in_ms : 0x2::clock::timestamp_ms(arg3) + arg4,
            image_url        : arg1,
            tier             : arg5,
            is_used          : false,
        }
    }

    public(friend) fun set_is_used<T0>(arg0: &mut Voucher<T0>) {
        arg0.is_used = true;
    }

    public(friend) fun set_new_balance<T0>(arg0: &mut Voucher<T0>, arg1: u64) {
        arg0.balance = arg1;
    }

    // decompiled from Move bytecode v6
}

