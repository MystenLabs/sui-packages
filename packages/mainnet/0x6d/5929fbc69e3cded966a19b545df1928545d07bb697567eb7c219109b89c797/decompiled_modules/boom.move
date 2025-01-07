module 0x6d5929fbc69e3cded966a19b545df1928545d07bb697567eb7c219109b89c797::boom {
    struct BOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOM>(arg0, 9, b"BOOM", b"BOOM", b"We bring the BOOM!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://boom.none.bar/boom.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOOM>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOM>>(v2, @0x5a3afb4e2d6421488d4417f8cbdaf276079dd6f9c0195d8c8453c7a56d863194);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

