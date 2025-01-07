module 0x343a6612df28090372bd49824fb5225ba6d2f797380d6da749386cb90de06934::Pithos23Coin {
    struct PITHOS23COIN has drop {
        dummy_field: bool,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PITHOS23COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PITHOS23COIN>>(0x2::coin::mint<PITHOS23COIN>(arg0, arg1, arg3), arg2);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    fun init(arg0: PITHOS23COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PITHOS23COIN>(arg0, 6, b"Pithos23Coin", b"Pithos23Coin", b"Pithos23 Coin des", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PITHOS23COIN>(&mut v2, 1000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PITHOS23COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PITHOS23COIN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

