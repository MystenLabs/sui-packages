module 0xf8e465aded0ede0875d2405421d0277a8b6dbbebe5acbdf90015dadeb04c460b::xunfragrantFaucet {
    struct XUNFRAGRANTFAUCET has drop {
        dummy_field: bool,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<XUNFRAGRANTFAUCET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<XUNFRAGRANTFAUCET>>(0x2::coin::mint<XUNFRAGRANTFAUCET>(arg0, arg1, arg3), arg2);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    fun init(arg0: XUNFRAGRANTFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XUNFRAGRANTFAUCET>(arg0, 6, b"XUNFRAGRANTFAUCET", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XUNFRAGRANTFAUCET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XUNFRAGRANTFAUCET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

