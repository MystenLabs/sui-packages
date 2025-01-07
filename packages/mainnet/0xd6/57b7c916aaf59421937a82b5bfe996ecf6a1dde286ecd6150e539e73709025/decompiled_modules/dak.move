module 0xd657b7c916aaf59421937a82b5bfe996ecf6a1dde286ecd6150e539e73709025::dak {
    struct DAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAK>(arg0, 6, b"dak", b"dak", b"Hi, I'm dak on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co/qJtYL10/ava-1.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DAK>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

