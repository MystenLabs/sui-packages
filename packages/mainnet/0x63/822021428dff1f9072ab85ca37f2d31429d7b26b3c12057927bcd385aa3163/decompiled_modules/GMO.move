module 0x63822021428dff1f9072ab85ca37f2d31429d7b26b3c12057927bcd385aa3163::GMO {
    struct GMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMO>(arg0, 8, b"GMO", b"Gamora", b"Gamora is a token that aims to facilitate the breakdown of society.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://shdw-drive.genesysgo.net/8za5sLK9jiTdxWaM9nXw7cdzWp2UBPvuFrXzV1EiNike/9127.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

