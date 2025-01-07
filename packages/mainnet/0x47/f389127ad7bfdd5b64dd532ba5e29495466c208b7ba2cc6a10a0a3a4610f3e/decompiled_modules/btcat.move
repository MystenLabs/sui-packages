module 0x47f389127ad7bfdd5b64dd532ba5e29495466c208b7ba2cc6a10a0a3a4610f3e::btcat {
    struct BTCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCAT>(arg0, 0, b"BTCat", b"BTCat", b"Tokens start at 1$, beating BTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bu5fld7zeafvdqkvn6czfadjun54xh4kmkftsgmjc3p6nny4fm7a.arweave.net/DTpVj_kgC1HBVW-FkoBpo3vLn4piizkZiRbf5rccKz4"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTCAT>>(v1);
        0x2::coin::mint_and_transfer<BTCAT>(&mut v2, 2100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BTCAT>>(v2);
    }

    // decompiled from Move bytecode v6
}

