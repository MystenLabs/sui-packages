module 0x6aa21843c40cce6b05e5f199794b4f5762cf0363fc86a7e17d5c01633980de25::SSHIBA {
    struct SSHIBA has drop {
        dummy_field: bool,
    }

    struct Storage has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<SSHIBA>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SSHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSHIBA>(arg0, 9, b"SSHIBA", b"SuiShiba", b"One of the very first meme coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://https-pinksale.finance/anhcuatung/shiba.png")), arg1);
        let v2 = 0x2::coin::treasury_into_supply<SSHIBA>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SSHIBA>>(0x2::coin::from_balance<SSHIBA>(0x2::balance::increase_supply<SSHIBA>(&mut v2, 600000000000000000), arg1), 0x2::tx_context::sender(arg1));
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = Storage{
            id     : 0x2::object::new(arg1),
            supply : v2,
        };
        0x2::transfer::share_object<Storage>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSHIBA>>(v1);
    }

    public fun total_supply(arg0: &Storage) : u64 {
        0x2::balance::supply_value<SSHIBA>(&arg0.supply)
    }

    // decompiled from Move bytecode v6
}

