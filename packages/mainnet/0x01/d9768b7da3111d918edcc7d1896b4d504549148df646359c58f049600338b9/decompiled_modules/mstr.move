module 0x1d9768b7da3111d918edcc7d1896b4d504549148df646359c58f049600338b9::mstr {
    struct MSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSTR>(arg0, 6, b"MSTR", b"MSTR", b"Follow MSTR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ivory-large-echidna-233.mypinata.cloud/ipfs/QmWa3LHPLR78gFh3qjryHjmgD3mNmHmGYmguMkg7HP9R8U"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSTR>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MSTR>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSTR>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

