module 0x19903bd415f2f7030cd56601cdc26e36800be4c7cde6f3aa8c3e481db35f2015::exit {
    struct EXIT has drop {
        dummy_field: bool,
    }

    struct TransferEvent has copy, drop {
        sender: address,
        amount: u64,
        recipient: address,
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<EXIT>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<EXIT>>(arg0, arg1);
        let v0 = TransferEvent{
            sender    : 0x2::tx_context::sender(arg2),
            amount    : 0x2::coin::value<EXIT>(&arg0),
            recipient : arg1,
        };
        0x2::event::emit<TransferEvent>(v0);
    }

    fun init(arg0: EXIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXIT>(arg0, 9, b"LORD", b"Lord", b"desc", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<EXIT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<EXIT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

