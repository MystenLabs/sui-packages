module 0xbd1b0b1d63931627b2772909a3d6f965ded8080bf6e019827860664ad0e70e5e::config {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct GlobalReserve has store, key {
        id: 0x2::object::UID,
        reserve: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun add_reserve(arg0: &mut GlobalReserve, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.reserve, arg1);
    }

    public fun admin(arg0: &GlobalConfig) : address {
        arg0.admin
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
        };
        let v1 = GlobalReserve{
            id      : 0x2::object::new(arg0),
            reserve : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<GlobalReserve>(v1);
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    // decompiled from Move bytecode v6
}

