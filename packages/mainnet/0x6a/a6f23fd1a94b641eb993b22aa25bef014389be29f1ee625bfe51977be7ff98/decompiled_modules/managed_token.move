module 0x6aa6f23fd1a94b641eb993b22aa25bef014389be29f1ee625bfe51977be7ff98::managed_token {
    struct MANAGED_TOKEN has drop {
        dummy_field: bool,
    }

    struct Minted has copy, drop {
        amount: u64,
        recipient: address,
        new_total_supply: u64,
    }

    struct Burned has copy, drop {
        amount: u64,
        new_total_supply: u64,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MANAGED_TOKEN>, arg1: 0x2::coin::Coin<MANAGED_TOKEN>) {
        let v0 = Burned{
            amount           : 0x2::coin::burn<MANAGED_TOKEN>(arg0, arg1),
            new_total_supply : 0x2::coin::total_supply<MANAGED_TOKEN>(arg0),
        };
        0x2::event::emit<Burned>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MANAGED_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MANAGED_TOKEN>>(0x2::coin::mint<MANAGED_TOKEN>(arg0, arg1, arg3), arg2);
        let v0 = Minted{
            amount           : arg1,
            recipient        : arg2,
            new_total_supply : 0x2::coin::total_supply<MANAGED_TOKEN>(arg0),
        };
        0x2::event::emit<Minted>(v0);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<MANAGED_TOKEN>) : u64 {
        0x2::coin::total_supply<MANAGED_TOKEN>(arg0)
    }

    fun init(arg0: MANAGED_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANAGED_TOKEN>(arg0, 9, b"ATHX", b"Aether Managed", b"Owner-controlled utility token of the InMotion Aether realm. Supply is minted/burned by the TreasuryCap holder for in-app supply management. Unaudited, design/testnet only.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://inmotion.tech/aether-managed.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANAGED_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANAGED_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_and_keep(arg0: &mut 0x2::coin::TreasuryCap<MANAGED_TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<MANAGED_TOKEN>>(0x2::coin::mint<MANAGED_TOKEN>(arg0, arg1, arg2), v0);
        let v1 = Minted{
            amount           : arg1,
            recipient        : v0,
            new_total_supply : 0x2::coin::total_supply<MANAGED_TOKEN>(arg0),
        };
        0x2::event::emit<Minted>(v1);
    }

    // decompiled from Move bytecode v7
}

