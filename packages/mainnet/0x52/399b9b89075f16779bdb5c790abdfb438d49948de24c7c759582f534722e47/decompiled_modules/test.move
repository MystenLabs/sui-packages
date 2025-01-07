module 0x52399b9b89075f16779bdb5c790abdfb438d49948de24c7c759582f534722e47::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TEST", b"Test Game", b"Today we dominate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/media/GJybQ29WwAE31jx?format=jpg&name=4096x4096"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

