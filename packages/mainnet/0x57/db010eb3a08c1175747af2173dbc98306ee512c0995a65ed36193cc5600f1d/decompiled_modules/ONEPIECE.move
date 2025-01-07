module 0x57db010eb3a08c1175747af2173dbc98306ee512c0995a65ed36193cc5600f1d::ONEPIECE {
    struct ONEPIECE has drop {
        dummy_field: bool,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<ONEPIECE>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: ONEPIECE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEPIECE>(arg0, 9, b"$SOP", b"SuiOnePiece", b"Anime MEME coin laucnh on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://https-pinksale.finance/anhcuatung/one.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<ONEPIECE>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<ONEPIECE>>(0x2::coin::from_balance<ONEPIECE>(0x2::balance::increase_supply<ONEPIECE>(&mut v2, 600000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = Storage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<Storage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONEPIECE>>(v1);
    }

    public fun total_supply(arg0: &Storage) : u64 {
        0x2::balance::supply_value<ONEPIECE>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

