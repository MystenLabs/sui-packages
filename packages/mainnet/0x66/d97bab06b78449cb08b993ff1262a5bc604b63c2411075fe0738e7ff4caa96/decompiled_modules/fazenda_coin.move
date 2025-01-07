module 0x66d97bab06b78449cb08b993ff1262a5bc604b63c2411075fe0738e7ff4caa96::fazenda_coin {
    struct FAZENDA_COIN has drop {
        dummy_field: bool,
    }

    struct TokenTreasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<FAZENDA_COIN>,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<FAZENDA_COIN>, arg1: 0x2::coin::Coin<FAZENDA_COIN>) {
        0x2::coin::burn<FAZENDA_COIN>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<FAZENDA_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<FAZENDA_COIN>>(0x2::coin::mint<FAZENDA_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: FAZENDA_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAZENDA_COIN>(arg0, 9, b"FZND", b"FazendaCoin", b"just fazenda/lol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ltdfoto.ru/images/2024/11/25/photo_2024-10-25_15-22-55.md.jpg")), arg1);
        let v2 = v0;
        let v3 = TokenTreasury{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<FAZENDA_COIN>(),
        };
        0x2::transfer::transfer<TokenTreasury>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAZENDA_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAZENDA_COIN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<FAZENDA_COIN>>(0x2::coin::mint<FAZENDA_COIN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

