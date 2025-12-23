module 0x490f2332bb9ab799c0bf5af895161574a3a0118a9676672c49892acc9584a470::kfl {
    struct KFL has drop {
        dummy_field: bool,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        coins: 0x2::coin::Coin<KFL>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut Treasury, arg1: 0x2::coin::Coin<KFL>) {
        0x2::coin::join<KFL>(&mut arg0.coins, arg1);
    }

    public fun decimals() : u8 {
        9
    }

    public fun deposit_to_treasury(arg0: &mut Treasury, arg1: 0x2::coin::Coin<KFL>) {
        0x2::coin::join<KFL>(&mut arg0.coins, arg1);
    }

    fun init(arg0: KFL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KFL>(arg0, 9, b"KFL", b"KFL Token", b"Sui-based utility token for service functionality", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kfl.io/logo.png")), arg1);
        let v2 = v0;
        let v3 = Treasury{
            id    : 0x2::object::new(arg1),
            coins : 0x2::coin::mint<KFL>(&mut v2, 1000000000000000000, arg1),
        };
        let v4 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KFL>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KFL>>(v1);
        0x2::transfer::share_object<Treasury>(v3);
        0x2::transfer::transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun total_supply() : u64 {
        1000000000000000000
    }

    public fun transfer_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun transfer_from_treasury(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KFL>>(withdraw(arg0, arg1, arg2, arg4), arg3);
    }

    public fun treasury_balance(arg0: &Treasury) : u64 {
        0x2::coin::value<KFL>(&arg0.coins)
    }

    public fun withdraw(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<KFL> {
        assert!(arg2 > 0, 1);
        assert!(0x2::coin::value<KFL>(&arg1.coins) >= arg2, 0);
        0x2::coin::split<KFL>(&mut arg1.coins, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

