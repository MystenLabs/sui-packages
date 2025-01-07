module 0xa3f2f661dc4f79aabdcf662a622d5e918d05d36cd3610ab25e3f3df0a3b25fa2::mstr {
    struct MSTR has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MSTR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MSTR>>(0x2::coin::mint<MSTR>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSTR>(arg0, 6, b"MSTR", b"MSTR", b"MSTR: 2100 Crypto enthusiasts, led by a bold CEO, stacked their sats, and crowned it the king of crypto stocks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ivory-large-echidna-233.mypinata.cloud/ipfs/QmWa3LHPLR78gFh3qjryHjmgD3mNmHmGYmguMkg7HP9R8U"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSTR>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MSTR>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSTR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

