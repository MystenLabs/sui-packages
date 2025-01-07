module 0xb33c5e60a4d688ef88d13280a0fce1f5a3b8adc453759194760912604ca3bdc0::zui {
    struct ZUI has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct CoinStore has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<ZUI>,
    }

    public fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<ZUI>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZUI>>(0x2::coin::mint<ZUI>(arg1, arg2, arg4), arg3);
    }

    public fun creditTokens(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<ZUI>, arg2: vector<address>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg2);
        let v1 = 0;
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 2);
        while (v1 < v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<ZUI>>(0x2::coin::mint<ZUI>(arg1, 0x1::vector::pop_back<u64>(&mut arg3), arg4), 0x1::vector::pop_back<address>(&mut arg2));
            v1 = v1 + 1;
        };
    }

    public fun debitToken(arg0: &mut CoinStore, arg1: 0x2::balance::Balance<ZUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<ZUI>(&mut arg0.balance, 0x2::coin::from_balance<ZUI>(arg1, arg2));
    }

    fun init(arg0: ZUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUI>(arg0, 18, b"ZUI", b"ZUI COIN", b"ZUI COIN is platform token for ZUI ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.vecteezy.com/system/resources/previews/020/468/890/original/zui-technology-letter-logo-design-on-white-background%20-zui-creative-initials-technology-letter-logo-concept-zui-technology-letter-design-vector.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZUI>>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

