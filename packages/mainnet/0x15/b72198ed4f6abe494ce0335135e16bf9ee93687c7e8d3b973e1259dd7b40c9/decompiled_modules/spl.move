module 0x15b72198ed4f6abe494ce0335135e16bf9ee93687c7e8d3b973e1259dd7b40c9::spl {
    struct SPL has drop {
        dummy_field: bool,
    }

    struct TokenMinted has copy, drop {
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    struct TokenBurned has copy, drop {
        amount: u64,
        burner: address,
        timestamp: u64,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SPL>, arg1: 0x2::coin::Coin<SPL>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<SPL>(arg0, arg1);
        let v0 = TokenBurned{
            amount    : 0x2::coin::value<SPL>(&arg1),
            burner    : 0x2::tx_context::sender(arg2),
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<TokenBurned>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SPL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SPL>>(0x2::coin::mint<SPL>(arg0, arg1, arg3), arg2);
        let v0 = TokenMinted{
            amount    : arg1,
            recipient : arg2,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<TokenMinted>(v0);
    }

    fun init(arg0: SPL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPL>(arg0, 9, b"SPL", b"SPL", b"Spl Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dapp.suipool.top/suipool.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPL>>(v1);
    }

    // decompiled from Move bytecode v6
}

