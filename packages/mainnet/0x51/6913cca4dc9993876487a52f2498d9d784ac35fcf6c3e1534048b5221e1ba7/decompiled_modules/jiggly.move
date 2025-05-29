module 0x516913cca4dc9993876487a52f2498d9d784ac35fcf6c3e1534048b5221e1ba7::jiggly {
    struct JIGGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JIGGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIGGLY>(arg0, 6, b"JIGGLY", b"Moon Jiggly", b"Shes pink, puffy, and packing bags. Moon Jiggly isn't here to play games she's here to sing your portfolio into the stratosphere.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiej676dno2agx7k24ckutsd7wvidtr3ea2qpj65na6gz4drplkzue")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIGGLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JIGGLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

