module 0x52caa7c8fffaa01f44b8536ceac76215d0787d43c45a61ad607bc20e9b09da9a::voucher {
    struct VOUCHER has drop {
        dummy_field: bool,
    }

    struct VoucherAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Voucher<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: u64,
        expiration: u64,
        image_url: 0x1::string::String,
        new_image_url: 0x1::string::String,
        used_image_url: 0x1::string::String,
        high_score: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        creator: 0x1::string::String,
    }

    public fun create_voucher_collection<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::display::Display<Voucher<T0>>>(0x2::display::new<Voucher<T0>>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: VOUCHER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VoucherAdminCap{id: 0x2::object::new(arg1)};
        0x2::package::claim_and_keep<VOUCHER>(arg0, arg1);
        0x2::transfer::transfer<VoucherAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_voucher<T0>(arg0: &mut VoucherAdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) : Voucher<T0> {
        Voucher<T0>{
            id             : 0x2::object::new(arg9),
            balance        : arg3,
            expiration     : 0x2::clock::timestamp_ms(arg4) + arg5,
            image_url      : arg1,
            new_image_url  : arg1,
            used_image_url : arg2,
            high_score     : 0,
            name           : arg6,
            description    : arg7,
            creator        : arg8,
        }
    }

    // decompiled from Move bytecode v6
}

