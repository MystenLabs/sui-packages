module 0x302e5de7240ce059d9a9127377bd867dea95083d1b614be7a67d499f9f696b2e::god {
    struct GOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOD>(arg0, 6, b"GOD", b"God", b"God powered by SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://lavender-negative-falcon-809.mypinata.cloud/ipfs/QmfCMqxnx1RALLPUG32mQDK9DZfcBTwqAfGy7tY79RCJUw"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOD>>(v1);
        0x2::coin::mint_and_transfer<GOD>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

