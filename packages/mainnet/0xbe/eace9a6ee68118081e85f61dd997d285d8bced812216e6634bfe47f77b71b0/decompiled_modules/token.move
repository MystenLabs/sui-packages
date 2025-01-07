module 0xbeeace9a6ee68118081e85f61dd997d285d8bced812216e6634bfe47f77b71b0::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Director has store, key {
        id: 0x2::object::UID,
        mintpaused: bool,
        claimpaused: bool,
        maxsupply: u64,
        mintsupply: u64,
        devaccount: address,
        treasury: 0x2::coin::TreasuryCap<TOKEN>,
    }

    struct Pantamint has key {
        id: 0x2::object::UID,
        mintcoin: u64,
        coin: u64,
    }

    public fun admin_claimpause(arg0: &mut Director, arg1: &AdminCap) {
        arg0.claimpaused = true;
    }

    public fun admin_claimresume(arg0: &mut Director, arg1: &AdminCap) {
        arg0.claimpaused = false;
    }

    public fun admin_destroy(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun admin_mintpause(arg0: &mut Director, arg1: &AdminCap) {
        arg0.mintpaused = true;
    }

    public fun admin_mintresume(arg0: &mut Director, arg1: &AdminCap) {
        arg0.mintpaused = false;
    }

    public fun claim(arg0: &mut Director, arg1: &mut Pantamint, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.claimpaused == false, 1002);
        assert!(0x2::coin::total_supply<TOKEN>(&arg0.treasury) + arg1.coin <= arg0.maxsupply, 1009);
        arg1.coin = 0;
        0x2::coin::mint_and_transfer<TOKEN>(&mut arg0.treasury, arg1.coin, 0x2::tx_context::sender(arg2), arg2);
    }

    public fun destroy(arg0: Pantamint) {
        let Pantamint {
            id       : v0,
            mintcoin : _,
            coin     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOKEN>(arg0, 6, b"PANTA", b"PANTA", b"The First Fair Launch Memecoin in the East.", 0x1::option::some<0x2::url::Url>(0xbeeace9a6ee68118081e85f61dd997d285d8bced812216e6634bfe47f77b71b0::icon::get_icon_url()), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v2);
        let v3 = Director{
            id          : 0x2::object::new(arg1),
            mintpaused  : true,
            claimpaused : true,
            maxsupply   : 50000000000000,
            mintsupply  : 0,
            devaccount  : v0,
            treasury    : v1,
        };
        0x2::coin::mint_and_transfer<TOKEN>(&mut v3.treasury, 15000000000000 + 4500000000000, v0, arg1);
        0x2::transfer::share_object<Director>(v3);
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut Director, arg1: &mut Pantamint, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mintpaused == false, 1001);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::tx_context::digest(arg3);
        let v2 = 0x2::bcs::to_bytes<address>(&v0);
        let v3 = 15 + ((((*0x1::vector::borrow<u8>(v1, 0) as u64) << 56 | (*0x1::vector::borrow<u8>(v1, 1) as u64) << 48 | (*0x1::vector::borrow<u8>(v1, 2) as u64) << 40 | (*0x1::vector::borrow<u8>(v1, 3) as u64) << 32) ^ ((*0x1::vector::borrow<u8>(&v2, 0) as u64) << 56 | (*0x1::vector::borrow<u8>(&v2, 1) as u64) << 48 | (*0x1::vector::borrow<u8>(&v2, 2) as u64) << 40 | (*0x1::vector::borrow<u8>(&v2, 3) as u64) << 32 | (*0x1::vector::borrow<u8>(&v2, 4) as u64) << 24 | (*0x1::vector::borrow<u8>(&v2, 5) as u64) << 16 | (*0x1::vector::borrow<u8>(&v2, 6) as u64) << 8 | (*0x1::vector::borrow<u8>(&v2, 7) as u64))) + ((*0x1::vector::borrow<u8>(v1, 4) as u64) << 24 | (*0x1::vector::borrow<u8>(v1, 5) as u64) << 16 | (*0x1::vector::borrow<u8>(v1, 6) as u64) << 8 | (*0x1::vector::borrow<u8>(v1, 7) as u64)) * 17 + 0x2::clock::timestamp_ms(arg2)) % 1000 % (35 - 15);
        let v4 = arg0.maxsupply;
        let v5 = 500000;
        assert!(arg0.mintsupply + v5 + v3 * 1000000 <= v4, 1009);
        assert!(0x2::coin::total_supply<TOKEN>(&arg0.treasury) + v3 * 1000000 <= v4, 1010);
        assert!(arg0.mintsupply + v5 + v3 * 1000000 <= 30000000000000, 1010);
        arg1.coin = arg1.coin + v3 * 1000000;
        arg1.mintcoin = arg1.mintcoin + v3 * 1000000;
        0x2::coin::mint_and_transfer<TOKEN>(&mut arg0.treasury, v5, arg0.devaccount, arg3);
        arg0.mintsupply = arg0.mintsupply + v5 + v3 * 1000000;
    }

    entry fun new_user(arg0: &Director, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.mintpaused == false, 1001);
        let v0 = Pantamint{
            id       : 0x2::object::new(arg1),
            mintcoin : 0,
            coin     : 0,
        };
        0x2::transfer::transfer<Pantamint>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun set_dev_account(arg0: &mut Director, arg1: &AdminCap, arg2: address) {
        arg0.devaccount = arg2;
    }

    // decompiled from Move bytecode v6
}

