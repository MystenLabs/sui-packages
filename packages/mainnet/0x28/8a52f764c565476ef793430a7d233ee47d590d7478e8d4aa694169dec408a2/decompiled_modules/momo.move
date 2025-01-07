module 0x288a52f764c565476ef793430a7d233ee47d590d7478e8d4aa694169dec408a2::momo {
    struct MOMO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOMO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOMO>>(0x2::coin::mint<MOMO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMO>(arg0, 6, b"MSTR", b"MSTR", b"MSTR: 2100 Crypto enthusiasts, led by a bold CEO, stacked their sats, and crowned it the king of crypto stocks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ivory-large-echidna-233.mypinata.cloud/ipfs/QmWa3LHPLR78gFh3qjryHjmgD3mNmHmGYmguMkg7HP9R8U"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOMO>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOMO>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

