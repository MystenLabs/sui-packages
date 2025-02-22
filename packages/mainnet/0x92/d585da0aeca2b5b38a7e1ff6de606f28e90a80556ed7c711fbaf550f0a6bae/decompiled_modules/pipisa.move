module 0x92d585da0aeca2b5b38a7e1ff6de606f28e90a80556ed7c711fbaf550f0a6bae::pipisa {
    struct PIPISA has drop {
        dummy_field: bool,
    }

    struct Holder has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<PIPISA>,
        cap: 0x2::coin::TreasuryCap<PIPISA>,
    }

    public fun burn(arg0: 0x2::coin::Coin<PIPISA>, arg1: &mut Holder, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<PIPISA>(&mut arg1.cap, arg0);
    }

    fun init(arg0: PIPISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPISA>(arg0, 6, b"PIPISA", b"PISA", b"Grow your dick with $PISA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.pinimg.com/736x/5a/0e/4c/5a0e4cd6dd54b1fc9dcc7f422e18b083.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIPISA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PIPISA>>(0x2::coin::mint<PIPISA>(&mut v2, 1000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = Holder{
            id      : 0x2::object::new(arg1),
            balance : 0x2::coin::into_balance<PIPISA>(0x2::coin::mint<PIPISA>(&mut v2, 1000000000000, arg1)),
            cap     : v2,
        };
        0x2::transfer::share_object<Holder>(v3);
    }

    public entry fun mint_user(arg0: &mut Holder, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PIPISA>>(0x2::coin::from_balance<PIPISA>(0x2::balance::split<PIPISA>(&mut arg0.balance, 100000000), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

