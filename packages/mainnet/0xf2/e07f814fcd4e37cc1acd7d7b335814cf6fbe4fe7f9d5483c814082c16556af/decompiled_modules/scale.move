module 0xf2e07f814fcd4e37cc1acd7d7b335814cf6fbe4fe7f9d5483c814082c16556af::scale {
    struct SCALE has drop {
        dummy_field: bool,
    }

    struct Reserve has key {
        id: 0x2::object::UID,
        status: u8,
        total_supply: 0x2::balance::Supply<SCALE>,
        scale_decimals: u8,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    public entry fun airdrop(arg0: &mut Reserve, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 2);
        assert!(arg1 <= 10000000000, 5);
        assert!(arg0.status == 1, 4);
        mint_to(arg0, arg1, arg2);
    }

    public entry fun burn(arg0: &mut Reserve, arg1: vector<0x2::coin::Coin<SCALE>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SCALE>>(&mut arg1);
        0x2::pay::join_vec<SCALE>(&mut v0, arg1);
        assert!(0x2::coin::value<SCALE>(&v0) > 0, 2);
        0x2::balance::decrease_supply<SCALE>(&mut arg0.total_supply, 0x2::coin::into_balance<SCALE>(v0));
    }

    public fun get_scale_decimals(arg0: &Reserve) : u8 {
        arg0.scale_decimals
    }

    public fun get_status(arg0: &Reserve) : u8 {
        arg0.status
    }

    public fun get_total_supply(arg0: &Reserve) : &0x2::balance::Supply<SCALE> {
        &arg0.total_supply
    }

    fun init(arg0: SCALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALE>(arg0, 6, b"SCALE", b"Scale", b"The Scale token is a test token used for development network and test network. see https://scale.exchange", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeibzo7s6gmeqybbecqhr2qaedjwxeprumg5kft5rvwicg2lpqzmo7y.ipfs.w3s.link/scale.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALE>>(v1);
        let v2 = Reserve{
            id             : 0x2::object::new(arg1),
            status         : 1,
            total_supply   : 0x2::coin::treasury_into_supply<SCALE>(v0),
            scale_decimals : 6,
        };
        0x2::transfer::share_object<Reserve>(v2);
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut AdminCap, arg1: &mut Reserve, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 2);
        mint_to(arg1, arg2, arg3);
    }

    fun mint_to(arg0: &mut Reserve, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SCALE>>(0x2::coin::from_balance<SCALE>(0x2::balance::increase_supply<SCALE>(&mut arg0.total_supply, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun set_staatus(arg0: &mut AdminCap, arg1: &mut Reserve, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 1 || arg2 == 2, 3);
        arg1.status = arg2;
    }

    // decompiled from Move bytecode v6
}

