module 0xc70161a9bdce5186d1480755ce389737b76153f5126c8e391aa591e4257d6cc1::usd {
    struct USD has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<USD>, arg1: 0x2::coin::Coin<USD>) {
        0x2::coin::burn<USD>(arg0, arg1);
    }

    fun init(arg0: USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USD>(arg0, 6, b"USD", b"TEXT TO PAY", b"SEND TRUMP CASH TODAY FROM MOST ANY PHONE TO ANY CONTACT OR WALLET 0X# COPYRIGHTS AND TRADEMARKS PROPERTY OF D.J.T. AND FAMILY. 2026-2096", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic7mzts6o5kagomihedmhav6mftahfc3tdahhmaxy5vucd2y3ftp4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USD>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<USD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<USD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

