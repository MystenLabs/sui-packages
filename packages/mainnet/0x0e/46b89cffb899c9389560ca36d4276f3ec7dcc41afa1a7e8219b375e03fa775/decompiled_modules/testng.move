module 0xe46b89cffb899c9389560ca36d4276f3ec7dcc41afa1a7e8219b375e03fa775::testng {
    struct TESTNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTNG>(arg0, 6, b"Testng", b"Testing", b"Just testing ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000386840_e28109c3fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

