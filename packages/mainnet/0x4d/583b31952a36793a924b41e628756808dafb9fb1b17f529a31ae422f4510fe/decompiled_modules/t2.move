module 0x4d583b31952a36793a924b41e628756808dafb9fb1b17f529a31ae422f4510fe::t2 {
    struct T2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T2>(arg0, 6, b"T2", b"Test 2", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/c603d373-49a9-4544-af5f-af3595c761c6.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<T2>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T2>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T2>>(v1);
    }

    // decompiled from Move bytecode v6
}

