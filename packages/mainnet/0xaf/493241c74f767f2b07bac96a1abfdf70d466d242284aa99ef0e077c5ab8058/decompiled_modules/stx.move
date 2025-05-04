module 0xaf493241c74f767f2b07bac96a1abfdf70d466d242284aa99ef0e077c5ab8058::stx {
    struct STX has drop {
        dummy_field: bool,
    }

    fun init(arg0: STX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STX>(arg0, 9, b"STX", b"Shitcoins Future Exchange", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSMPi8rTPQpXLfSXQPAvaLvPu1bikC8spVvkasQfEyB8C")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

