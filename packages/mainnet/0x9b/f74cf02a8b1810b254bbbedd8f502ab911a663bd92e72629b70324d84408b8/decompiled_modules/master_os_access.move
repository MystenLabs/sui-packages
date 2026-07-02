module 0x9bf74cf02a8b1810b254bbbedd8f502ab911a663bd92e72629b70324d84408b8::master_os_access {
    struct MASTER_OS_ACCESS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MASTER_OS_ACCESS>, arg1: 0x2::coin::Coin<MASTER_OS_ACCESS>) {
        0x2::coin::burn<MASTER_OS_ACCESS>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MASTER_OS_ACCESS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<MASTER_OS_ACCESS>>(0x2::coin::mint<MASTER_OS_ACCESS>(arg0, arg1, arg3), arg2);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<MASTER_OS_ACCESS>) : u64 {
        0x2::coin::total_supply<MASTER_OS_ACCESS>(arg0)
    }

    fun init(arg0: MASTER_OS_ACCESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASTER_OS_ACCESS>(arg0, 6, b"MOSA", b"Master OS Access", b"Utility/access token for the Master OS ecosystem. Not a security.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/REPLACE_ME/master_os/main/icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MASTER_OS_ACCESS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASTER_OS_ACCESS>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_batch(arg0: &mut 0x2::coin::TreasuryCap<MASTER_OS_ACCESS>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            assert!(v2 > 0, 0);
            0x2::transfer::public_transfer<0x2::coin::Coin<MASTER_OS_ACCESS>>(0x2::coin::mint<MASTER_OS_ACCESS>(arg0, v2, arg3), *0x1::vector::borrow<address>(&arg1, v1));
            v1 = v1 + 1;
        };
    }

    public entry fun transfer_coin(arg0: 0x2::coin::Coin<MASTER_OS_ACCESS>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MASTER_OS_ACCESS>>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

