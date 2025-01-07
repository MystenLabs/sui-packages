module 0x276548daf1f432095ebebeb4a22caf6d3cb3c7efc454397f825953873534eb4b::suipernatural {
    struct SUIPERNATURAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERNATURAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERNATURAL>(arg0, 6, b"SUIPERNATURAL", b"SUIPERNATURAL", b"It's that time of the YEAR, Halloween has come early on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/cQkJHGU.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPERNATURAL>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERNATURAL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPERNATURAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

