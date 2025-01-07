module 0xaa002edcd5d03a005aa530bdc5079b52c1449a62eaf8c56067578de80ae8e076::time_ {
    struct TIME_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIME_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIME_>(arg0, 9, b"TIME", b"TIMES UP", b"Time go quick", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ak.picdn.net/shutterstock/videos/33122137/thumb/10.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TIME_>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIME_>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIME_>>(v1);
    }

    // decompiled from Move bytecode v6
}

