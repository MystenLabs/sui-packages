module 0x4dddcb945d5aa88a03f0f3f88c78dbed2ab34086a22a5e7c44a06ed6bddf5e22::voucher {
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

    public fun create_voucher_collection<T0>(arg0: &0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::display::Display<Voucher<T0>>>(0x2::display::new<Voucher<T0>>(arg0, arg2), arg1);
    }

    public fun deduct_balance<T0, T1: drop>(arg0: T1, arg1: &0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::UniHouse, arg2: &mut Voucher<T0>, arg3: u64) {
        assert!(0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::house::game_config_exists<T0, T1>(0x90a88c7fe8931d467f6364839b9db3b0a7744084664817de5ed709885e086ff0::unihouse::borrow_house<T0>(arg1)), 0);
        arg2.balance = arg2.balance - arg3;
        if (!arg2.is_used) {
            arg2.is_used = true;
            arg2.image_url = get_voucher_url(arg2.tier, arg2.is_used);
        };
    }

    public fun expiration_in_ms<T0>(arg0: &Voucher<T0>) : u64 {
        arg0.expiration_in_ms
    }

    public fun get_voucher_url(arg0: u8, arg1: bool) : 0x1::string::String {
        if (arg0 == 1 && !arg1) {
            return 0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeid2cdugrcqrersxpzf5tqkuehg7nypjriz4ecx3pcmih5ojhjru5y/1.webp")
        };
        if (arg0 == 1 && arg1) {
            return 0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeid2cdugrcqrersxpzf5tqkuehg7nypjriz4ecx3pcmih5ojhjru5y/2.webp")
        };
        if (arg0 == 2 && !arg1) {
            return 0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeid2cdugrcqrersxpzf5tqkuehg7nypjriz4ecx3pcmih5ojhjru5y/3.webp")
        };
        if (arg0 == 2 && arg1) {
            return 0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeid2cdugrcqrersxpzf5tqkuehg7nypjriz4ecx3pcmih5ojhjru5y/4.webp")
        };
        if (arg0 == 3 && !arg1) {
            return 0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeid2cdugrcqrersxpzf5tqkuehg7nypjriz4ecx3pcmih5ojhjru5y/5.webp")
        };
        0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeid2cdugrcqrersxpzf5tqkuehg7nypjriz4ecx3pcmih5ojhjru5y/6.webp")
    }

    public fun image_url<T0>(arg0: &Voucher<T0>) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: VOUCHER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VoucherAdminCap{id: 0x2::object::new(arg1)};
        0x2::package::claim_and_keep<VOUCHER>(arg0, arg1);
        0x2::transfer::transfer<VoucherAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_used<T0>(arg0: &Voucher<T0>) : bool {
        arg0.is_used
    }

    public fun mint_voucher<T0>(arg0: &mut VoucherAdminCap, arg1: u64, arg2: &0x2::clock::Clock, arg3: u64, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) : Voucher<T0> {
        Voucher<T0>{
            id               : 0x2::object::new(arg5),
            balance          : arg1,
            expiration_in_ms : 0x2::clock::timestamp_ms(arg2) + arg3,
            image_url        : get_voucher_url(arg4, false),
            tier             : arg4,
            is_used          : false,
        }
    }

    public fun tier<T0>(arg0: &Voucher<T0>) : u8 {
        arg0.tier
    }

    // decompiled from Move bytecode v6
}

