module 0xb43814a1c10ec2167507c6635bd9e1c8592430b4a55d343acab6bf5c55a4a8e8::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"test", b"test", b"DONT BUY OK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v2, @0x191726a4470b439a8353879cbcb7a67617e78ef938eb3b8cd5a0cf1cf285ce8f);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST>>(v1);
    }

    // decompiled from Move bytecode v6
}

