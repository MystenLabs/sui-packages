module 0x7452e8c0cb624a511dd697a2d35122afe17574c97538814fa3757f10728073c1::Pew {
    struct PEW has drop {
        dummy_field: bool,
    }

    public entry fun transfer(arg0: &mut 0x2::coin::Coin<PEW>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEW>>(0x2::coin::split<PEW>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEW>(arg0, 6, b"PEW", b"pepe in a memes world", b"$PEW includes a collection of pepe memes designed by his Artist and Community of $PEW. $PEW was deployed for degen shitcoin trading and gambling on the ethereum blockchain.The $PEW memecoin, a collection of never ending pepe memes. - pepe in a memes world , OH FUKC.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/vTwbDb07/pew.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PEW>>(0x2::coin::mint<PEW>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEW>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEW>>(v2);
    }

    // decompiled from Move bytecode v6
}

