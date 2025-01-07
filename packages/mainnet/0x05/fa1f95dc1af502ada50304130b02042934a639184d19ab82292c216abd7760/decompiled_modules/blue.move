module 0x5fa1f95dc1af502ada50304130b02042934a639184d19ab82292c216abd7760::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<T0>,
    }

    public entry fun burn_tokens(arg0: &mut TreasuryCapHolder<BLUE>, arg1: 0x2::coin::Coin<BLUE>) {
        0x2::coin::burn<BLUE>(&mut arg0.treasury, arg1);
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 9, b"BLUE", b"Bluefin", b"BLUE is the native token of Bluefin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bluefin.io/images/square.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUE>>(v1);
        let v2 = TreasuryCapHolder<BLUE>{
            id       : 0x2::object::new(arg1),
            treasury : v0,
        };
        0x2::transfer::public_transfer<TreasuryCapHolder<BLUE>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_tokens(arg0: &mut TreasuryCapHolder<BLUE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<BLUE>(&arg0.treasury) + arg1 <= 1000000000000000000, 1);
        0x2::coin::mint_and_transfer<BLUE>(&mut arg0.treasury, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

