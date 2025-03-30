module 0x900d0a29da2c1ee11a0e1b77792db012cf7e6f06cc139978b956106c87cb2cbd::pikachu {
    struct PIKACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKACHU>(arg0, 6, b"pikaCHU", b"pikaCHU Run", x"484159495220616e6c616d61646e2e20446564696d206b6920796168752e2e2120427520646e79612062656e696d204d454d4c454b45542e20200a4e4f2c20796f75206469646e277420756e6465727374616e642e204920736169642c206d616e2e2e21205468697320776f726c64206973206d7920484f4d454c414e442e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000651_7ab49d56ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKACHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIKACHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

