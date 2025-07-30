module 0xc436a8ccc36e649e0fd8c7cec88ca89747b69ba5bdefb15be2f93ae1ae632800::weis {
    struct WEIS has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<WEIS>, arg1: 0x2::coin::Coin<WEIS>) : u64 {
        0x2::coin::burn<WEIS>(arg0, arg1)
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WEIS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WEIS>>(0x2::coin::mint<WEIS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: WEIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEIS>(arg0, 9, b"WEIS", b"WEIS DAO", b"WEIS is the governance token of Weiss.Finance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://purple-efficient-armadillo-520.mypinata.cloud/ipfs/bafkreickahkpchfakjsaq4rdnugq25lrcbdgfz6nawswlr3mlmhdwlyiju"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WEIS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEIS>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<WEIS>>(0x2::coin::mint<WEIS>(&mut v2, 100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint_and_return_coin_dori(arg0: &mut 0x2::coin::TreasuryCap<WEIS>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<WEIS> {
        0x2::coin::mint<WEIS>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

