module 0x3eede9beb0474fb0ddec33d9e889d0011106dadc67cf1144cce38c918f18b01f::hood {
    struct HOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOOD>(arg0, 9, b"HOOD", b"Robinhood", b"Robinhood colluded with Wall Street. We're taking their market cap and giving it to the people. $HOOD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreihz4vfass23wcohztnlslueetpbpgm2rvvlsioxbhdh3v6kjm7cuy")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOOD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOOD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOOD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

