module 0xe4223cd0b5a4aea374c0beb94e9f8014f70d791fec61aaa33a05b7bcec30af79::tsttt {
    struct TSTTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSTTT>(arg0, 9, b"TSTTT", b"Test Coin", b"asd asdasdas dasdasdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://static.vecteezy.com/system/resources/previews/013/567/018/original/a-cute-monkey-avatar-on-a-green-background-vector.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TSTTT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTTT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSTTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

