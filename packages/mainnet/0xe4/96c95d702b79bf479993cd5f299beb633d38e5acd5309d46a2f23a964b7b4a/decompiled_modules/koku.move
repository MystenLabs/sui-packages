module 0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::koku {
    struct KOKU has drop {
        dummy_field: bool,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<KOKU>,
    }

    public fun burn(arg0: &mut Vault, arg1: 0x2::coin::Coin<KOKU>) : u64 {
        0x2::coin::burn<KOKU>(&mut arg0.treasury, arg1)
    }

    public fun total_supply(arg0: &Vault) : u64 {
        0x2::coin::total_supply<KOKU>(&arg0.treasury)
    }

    fun init(arg0: KOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOKU>(arg0, 0, b"KOKU", b"Koku", b"Rice-standard currency of Sui Samurai. Earned through disciplined training, burned at the forge.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOKU>>(v1);
        let v2 = Vault{
            id       : 0x2::object::new(arg1),
            treasury : v0,
        };
        0x2::transfer::share_object<Vault>(v2);
    }

    public fun mint(arg0: &0x8fcb3f15b2652a01eb01fd3cf9c4d4a94a4009ef449bce0df0d304414c254034::samurai::GameCap, arg1: &mut Vault, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KOKU>(&mut arg1.treasury, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

