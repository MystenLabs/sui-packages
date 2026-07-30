module 0x660ee5a441839f9ed1b0ce1f4b460b09af790cd4868fe3802175c483d1964483::my_token {
    struct MY_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_TOKEN>(arg0, 9, b"XSUC", b"XSUC Token", b"XSUC Token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmYCM3CrXaHk3F3fuqgSAc6ESJim82Wz7oveeqZGo7zYYN/bafkreieqdtzkljdbvkoy3b5mxjmhqu43wfrhvyofpzk3h2rho5ymqett7i.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_TOKEN>>(0x2::coin::mint<MY_TOKEN>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_TOKEN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

