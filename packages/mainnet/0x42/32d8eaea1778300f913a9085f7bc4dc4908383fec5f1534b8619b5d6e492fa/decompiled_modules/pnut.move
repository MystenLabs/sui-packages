module 0x4232d8eaea1778300f913a9085f7bc4dc4908383fec5f1534b8619b5d6e492fa::pnut {
    struct PNUT has drop {
        dummy_field: bool,
    }

    struct CoinCreatedEvent has copy, drop {
        total_supply: u64,
        decimals: u8,
        symbol: vector<u8>,
        name: vector<u8>,
        creater: address,
    }

    fun init(arg0: PNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUT>(arg0, 9, b"PNUT", b"PNUT", b"In long loving memory of PNUT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreidifvmu7z7isixq72gp6s4i2oeycv4hrfe2rswkhv6ktf57zlslgy")), arg1);
        let v2 = v0;
        let v3 = 0x2::coin::mint<PNUT>(&mut v2, 10000000000000000000, arg1);
        let v4 = CoinCreatedEvent{
            total_supply : 10000000000000000000,
            decimals     : 9,
            symbol       : b"PNUT",
            name         : b"PNUT COIN",
            creater      : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<CoinCreatedEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<PNUT>>(0x2::coin::split<PNUT>(&mut v3, 500000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<PNUT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PNUT>>(v2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

