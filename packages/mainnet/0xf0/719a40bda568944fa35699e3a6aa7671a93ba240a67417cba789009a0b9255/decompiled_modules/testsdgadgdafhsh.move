module 0xf0719a40bda568944fa35699e3a6aa7671a93ba240a67417cba789009a0b9255::testsdgadgdafhsh {
    struct TESTSDGADGDAFHSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTSDGADGDAFHSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTSDGADGDAFHSH>(arg0, 6, b"testsdgadgdafhsh", b"testfhf", b"gshshshfdsh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/undefined?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTSDGADGDAFHSH>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTSDGADGDAFHSH>>(v2, @0xa5b1611d756c1b2723df1b97782cacfd10c8f94df571935db87b7f54ef653d66);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTSDGADGDAFHSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

